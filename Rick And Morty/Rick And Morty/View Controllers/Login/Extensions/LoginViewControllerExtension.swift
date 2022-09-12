//
//  LoginViewControllerExtension.swift
//  Rick And Morty
//
//  Created by Dmitriy Pirko on 08.09.2022.
//

import Foundation
import UIKit

//hide keyboard
extension LoginViewController: UITextFieldDelegate {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
