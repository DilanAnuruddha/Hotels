//
//  HomeViewController.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//

import UIKit
import FBSDKLoginKit

class HomeViewController: UIViewController {
    
    var hotelViewModels = [HotelViewModel]()
    var user:User?

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getHotelData()
    }
    
    //MARK: Components
    let (loader,loaderBackground) = Components.getLoaderViewSet()
    
    let lblName:UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        lbl.text = "--"
        return lbl
    }()
    
    let lblEmail:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        lbl.text = "--"
        return lbl
    }()
    
    let tblHotel:UITableView = {
        let tbl = UITableView(frame: .zero, style: .plain)
        return tbl
    }()
    
    //MARK: Setup UI
    func setupView() {
        view.addSubViews(lblName,lblEmail,tblHotel)
        NSLayoutConstraint.activate([
        
            lblName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lblName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            lblEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lblEmail.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 2),
            
            tblHotel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tblHotel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tblHotel.topAnchor.constraint(equalTo: lblEmail.bottomAnchor,constant: 24),
            tblHotel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tblHotel.delegate = self
        tblHotel.dataSource = self
        tblHotel.register(HotelCell.self, forCellReuseIdentifier: TableViewCellId.Hotel)
        tblHotel.rowHeight = UITableView.automaticDimension
        tblHotel.estimatedRowHeight = 100
    }
}

//MARK: TableView Delegates
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellId.Hotel, for: indexPath) as! HotelCell
        let hotel = hotelViewModels[indexPath.row]
        cell.lblTitle.text = hotel.title
        cell.lblAddress.text = hotel.address
        cell.imgPic.setImage(url: URL(string: hotel.image.small)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.hotel = hotelViewModels[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

//MARK: Functions
extension HomeViewController {
    
    //Configure the navigation bar
    fileprivate func configNavBar(){
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        navigationItem.title = "Hotels"
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target:self , action: #selector(didClickedBtnLogout))
    }
    
    //Load data to user labels
    fileprivate func loadData(){
        lblName.text = user?.name
        lblEmail.text = user?.email
    }
    
    //fetch hotel list
    fileprivate func getHotelData(){
        if CheckConnection.isConnected() {
            addLoaderToView(view: self.view, loader: self.loader, loaderBackground: self.loaderBackground)
            
            Services.getHotelList { (hotels, error) in
                if let err = error {
                    print("Failed to fetch courses:", err)
                    self.removeLoader(loader: self.loader, loaderBackground: self.loaderBackground)
                    Alert.showDefaultAlert(on: self, title: "ERROR!", message: err.localizedDescription)
                    return
                }
                
                self.hotelViewModels = hotels?.map({return HotelViewModel(hotel: $0)}) ?? []
                self.tblHotel.reloadData()
                self.removeLoader(loader: self.loader, loaderBackground: self.loaderBackground)
            }
        }else{
            Alert.showNoConnectionAlert(on: self)
        }
    }
    
    //Logout event handler
    @objc fileprivate func didClickedBtnLogout(){
        
        let confirmAlert = UIAlertController(title: "Confirm", message: "Are you sure want to log out?", preferredStyle: .alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { (acttion) in
            let loginManager = LoginManager()
            loginManager.logOut()
            self.goToLoginView()
        }))
        confirmAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(confirmAlert, animated: true, completion: nil)
    }
    
    //change rootview to login
    fileprivate func goToLoginView(){
        let loginVC = LoginViewController()
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = UINavigationController(rootViewController: loginVC)
    }
}
