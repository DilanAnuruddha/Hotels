//
//  ViewController.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//

import UIKit

class DetailViewController: UIViewController {
    var hotel: HotelViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showData()
    }
    
    //MARK: Components
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        return lbl
    }()
    
    let lblDescription : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        lbl.numberOfLines = 0
        lbl.textAlignment = .justified
        return lbl
    }()
    
    let imgPic: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    //MARK: Setup UI
    func setupView()  {
        view.addSubViews(lblTitle,lblDescription,imgPic)
        NSLayoutConstraint.activate([
            imgPic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgPic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            imgPic.widthAnchor.constraint(equalToConstant: 120),
            imgPic.heightAnchor.constraint(equalToConstant: 120),
            
            lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lblTitle.topAnchor.constraint(equalTo: imgPic.bottomAnchor, constant: 24),
            
            lblDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            //lblDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        imgPic.layer.cornerRadius = 60
    }
}

//MARK: Functions
extension DetailViewController {
    
    //Configure the navigation bar
    fileprivate func configNavBar(){
        navigationItem.title = "Details"
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        var icon: UIImage?
        if #available(iOS 13.0, *) {
            icon = UIImage(systemName: "location.fill")
        } else {
            icon = UIImage(named: "location.png")
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon , style: .plain, target: self, action: #selector(didClickedLocation))
    }
    
    //load data to labels
    fileprivate func showData(){
        lblTitle.text = hotel?.title
        lblDescription.text = hotel?.hotelDescription
        imgPic.setImage(url: URL(string: hotel!.image.small)!)
    }
    
    //location button click handler
    @objc fileprivate func didClickedLocation(){
        let locationVC = LocationViewController()
        locationVC.hotel = hotel
        let navController = UINavigationController(rootViewController: locationVC)
        navController.modalPresentationStyle = .pageSheet
        self.present(navController, animated: true)
    }
}
