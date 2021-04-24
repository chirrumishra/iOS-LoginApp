//
//  Utilities.swift
//  BLACKCOFFER
//
//  Created by Chiranjeev Mishra on 18/04/21.
//

import Foundation
import UIKit

class Utilities {
    static func ShowNextPage(_ VC:UIViewController) {
        
    }

    
    static func PresentNextPage(_ VC:UIViewController){
        
    }
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        // Remove border on text field
        textfield.borderStyle = .none
        textfield.layer.borderColor =  #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 5.0
        button.tintColor = UIColor.white
    }
    
    static func styleLoginButton(_ button:UIButton) {
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
    }
}
