//
//  FinalVC.swift
//  BLACKCOFFER
//
//  Created by Chiranjeev Mishra on 18/04/21.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit

class FinalVC: UIViewController {

    
    @IBOutlet weak var LogoutButoon: UIButton!
    @IBOutlet weak var variable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(LogoutButoon)
        variable.text = StoringVariables.Uploading.NameOfUser

    }
    
    @IBAction func LogoutTapped(_ sender: Any) {
        StoringVariables.Uploading.NameOfUser = "Welcome"

        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            // next line presenting whole sceen
            newViewController.modalTransitionStyle = .crossDissolve
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
//            self.lb_login_Status.text = "Please login now"
//            self.btn_sign_out.isHidden = true
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }

}
