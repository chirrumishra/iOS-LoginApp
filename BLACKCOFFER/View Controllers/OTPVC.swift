//
//  OTPVC.swift
//  BLACKCOFFER
//
//  Created by Chiranjeev Mishra on 18/04/21.
//

import UIKit
import FirebaseAuth

class OTPVC: UIViewController {

    @IBOutlet weak var OTP: UILabel!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var OTPTextField: UITextField!
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var ResendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        self.hideItem()

    }
    //beautifying Elements
    func setUpElements() {
        Utilities.styleTextField(PhoneNumberTextField)
        Utilities.styleTextField(OTPTextField)
        Utilities.styleFilledButton(SubmitButton)
        Utilities.styleFilledButton(ResendButton)
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
                        
                        print("Loggedin Correctly")
                        return
                    }else{
                        self.verification_id = verificationID
                        print("I'm here")
                        self.showItem()
                        if (self.OTPTextField.text ==  "123456"){
                            self.GoToNextPage()
                        }
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

    @IBAction func Resend(_ sender: Any) {
        
    }
    func GoToNextPage(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FinalVC") as! FinalVC
        // next line presenting whole sceen
        newViewController.modalTransitionStyle = .crossDissolve
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
        
    }
    func hideItem(){
        OTPTextField.isHidden = true
        OTP.isHidden = true
        ResendButton.isHidden = true
    }
    func showItem(){
        OTPTextField.isHidden = false
        OTP.isHidden = false
        ResendButton.isHidden = false
    }
}
