//
//  LoginViewController.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkLoginStatus()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: Components
    let (loader,loaderBackground) = Components.getLoaderViewSet()
    
    let lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome to the Hotels"
        lbl.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let btnLogin : FBLoginButton = {
        let btn = FBLoginButton()
        btn.permissions = ["public_profile","email"]
        return btn
    }()
    
    
    //MARK:Setup UI
    func setupView()  {
        view.addSubViews(lblTitle,btnLogin)
        NSLayoutConstraint.activate([
            lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            
            btnLogin.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btnLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnLogin.widthAnchor.constraint(equalToConstant: 200),
        ])
        btnLogin.delegate = self
    }

}

//MARK: FB login delegates
extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        getFBUserData()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
       
    }
}

//MARK: Functions
extension LoginViewController {
    
    fileprivate func checkLoginStatus(){
        getFBUserData()
    }
    
    fileprivate func getFBUserData(){
        
        if(AccessToken.current != nil) {
            if CheckConnection.isConnected() {
                addLoaderToView(view: self.view, loader: loader, loaderBackground: loaderBackground)
                
                let connection = GraphRequestConnection()
                connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"email,name"])) { httpResponse, result, error   in
                    if error != nil {
                        NSLog(error.debugDescription)
                        self.removeLoader(loader: self.loader, loaderBackground: self.loaderBackground)
                        return
                    }

                    if let result = result as? [String:String] {
                        print(result)
                        let homeVC = HomeViewController()
                        homeVC.user = User(id: Int(result["id"] ?? "0")!, name: result["name"] ?? "" , email: result["email"] ?? "")
                        self.removeLoader(loader: self.loader, loaderBackground: self.loaderBackground)
                        self.navigationController?.pushViewController(homeVC, animated: true)
                    }else{
                        self.removeLoader(loader: self.loader, loaderBackground: self.loaderBackground)
                    }
                }
                connection.start()
            }else{
                Alert.showNoConnectionAlert(on: self)
            }
        }else{
            
        }
    }
}
