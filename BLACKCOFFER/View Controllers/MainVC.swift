//
//  MainVC.swift
//  BLACKCOFFER
//
//  Created by Chiranjeev Mishra on 18/04/21.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class MainVC: UIViewController , GIDSignInDelegate{

    @IBOutlet weak var GoogleLoginButton : UIButton!
    @IBOutlet weak var FacebookLoginButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Google Sign in
        GIDSignIn.sharedInstance()?.delegate = self
        //Styling 
        Utilities.styleLoginButton(GoogleLoginButton)
        Utilities.styleLoginButton(FacebookLoginButton)

    }
   
    @IBAction func GoogleLoginTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        
        debugPrint(StoringVariables.Uploading.NameOfUser)
        //Google Login Stuff here
    }
    
    @IBAction func FacebookLoginTapped(_ sender: Any) {
        //Facebook Login Stuff here
        let loginManager = LoginManager()
       loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
           if let error = error {
               print("Failed to login: \(error.localizedDescription)")
               return
           }
           
           guard let accessToken = AccessToken.current else {
               print("Failed to get access token")
               return
           }

           let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
           
           // Perform login by calling Firebase APIs
           Auth.auth().signIn(with: credential, completion: { (user, error) in
               if let error = error {
                   print("Login error: \(error.localizedDescription)")
                   let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                   let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                   alertController.addAction(okayAction)
                   self.present(alertController, animated: true, completion: nil)
                   return
               }else {
                   self.currentUserName()
                   self.NextStoryBoard()
               }
           
           })

       }
        
    }
    
    @IBAction func PhoneVerification(_ sender:Any){
        self.PhoneStoryBoard()
        
    }
    
    func NextStoryBoard(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FinalVC") as! FinalVC
        // next line presenting whole sceen
        newViewController.modalTransitionStyle = .crossDissolve
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func PhoneStoryBoard(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
        // next line presenting whole sceen
        newViewController.modalTransitionStyle = .crossDissolve
        //newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    func currentUserName()  {
            if let currentUser = Auth.auth().currentUser {
                //self.btn_sign_out.isHidden = false
                StoringVariables.Uploading.NameOfUser = "WELCOME " +  (currentUser.displayName ?? "DISPLAY NAME NOT FOUND")
            }
        }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if error != nil {
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
    
        //Do what ever you want to do
        
        Auth.auth().signIn(with: credential, completion: {(authResult, error) in
            if let error = error{
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            else{
                self.NextStoryBoard()
                self.currentUserName()
                return
            }
        })
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //Perform operation with use declined
    }
    
}
