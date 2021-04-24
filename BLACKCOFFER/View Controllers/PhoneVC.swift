//
//  PhoneVC.swift
//  BLACKCOFFER
//
//  Created by Chiranjeev Mishra on 18/04/21.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class PhoneVC: UIViewController {

    @IBOutlet weak var NameOfUser: UILabel!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var OTPTextField: UITextField!
    @IBOutlet weak var SubmitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        NameOfUser.text = StoringVariables.Uploading.NameOfUser
        OTPTextField.isHidden = true
        
    }
    //beautifying Elements
    func setUpElements() {
        Utilities.styleTextField(PhoneNumberTextField)
        Utilities.styleTextField(OTPTextField)
        Utilities.styleFilledButton(SubmitButton)
    }
    
    @IBAction func GoBack(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        // next line presenting whole sceen
        newViewController.modalTransitionStyle = .crossDissolve
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    //Phone Auth
    var verification_id : String? = nil
    @IBAction func SubmitTapped(_ sender:Any){
        if OTPTextField.isHidden {
            if !PhoneNumberTextField.text!.isEmpty{
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                PhoneAuthProvider.provider().verifyPhoneNumber(PhoneNumberTextField.text!, uiDelegate: nil, completion: {verificationID, error in
                    if (error != nil){
                        return
                    }else{
                        self.verification_id = verificationID
                    }
                })
                
            }else {
                print("Please entter your mobile number")
            }
            
        }else {
            if verification_id != nil {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification_id!, verificationCode: OTPTextField.text!)
                Auth.auth().signIn(with: credential, completion: {authData, error in
                    if (error != nil){
                        print(error.debugDescription)
                    } else{
                        print("Authentication Sucess wth - " + (authData?.user.phoneNumber ?? "NO PHONE NUMBER" ))
                        self.GoToNextPage()
                    }
                })
            }else{
                print("Error in getting verification OTP")
            }
            
        }
        
    }

    
    func GoToNextPage(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FinalVC") as! FinalVC
        // next line presenting whole sceen
        newViewController.modalTransitionStyle = .crossDissolve
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
        
    }
}
