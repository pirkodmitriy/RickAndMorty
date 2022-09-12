//
//  ViewController.swift
//  Rick And Morty
//
//  Created by Dmitriy Pirko on 08.09.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var mainViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var signErrorLabel: UILabel!
    
    private let networkManager = NetworkManager()
    private let signManger = SignManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        isAlreadySignIn()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        signInButton.layer.cornerRadius = 10
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        // UI changes when keyboard appear
        keyboardNotifications()
        let keyboardTapGesture = UITapGestureRecognizer(target: self, action: #selector(clearKeyboard))
        view.addGestureRecognizer(keyboardTapGesture)
        keyboardTapGesture.cancelsTouchesInView = false
    }
    
    private func isAlreadySignIn() {
        if signManger.getSignStatus() {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "tabBar", sender: Any?.self)
            }
        }
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            networkManager.signIn(parameters: SignModel(email: emailTextField.text!, password: passwordTextField.text!)) { result in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try! decoder.decode(SignJSON.self, from: Data(result.utf8))
                if !(result.token?.isEmpty ?? true) {
                    DispatchQueue.main.async {
                        self.signManger.setToken(token: result.token ?? "error token")
                        self.emailTextField.text?.removeAll()
                        self.passwordTextField.text?.removeAll()
                        self.performSegue(withIdentifier: "tabBar", sender: Any?.self)
                    }
                } else {
                    if !(result.email?.isEmpty ?? true) {
                        DispatchQueue.main.async {
                            self.signErrorLabel.text = result.email?.first
                        }
                    } else if !(result.password?.isEmpty ?? true) {
                        DispatchQueue.main.async {
                            self.signErrorLabel.text = result.password?.first
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            networkManager.signUp(parameters: SignModel(email: emailTextField.text!, password: passwordTextField.text!)) { result in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try! decoder.decode(SignJSON.self, from: Data(result.utf8))
                if !(result.email?.isEmpty ?? true) {
                    DispatchQueue.main.async {
                        self.signErrorLabel.text = result.email?.first
                    }
                } else if !(result.password?.isEmpty ?? true) {
                    DispatchQueue.main.async {
                        self.signErrorLabel.text = result.password?.first
                    }
                } else if !(result.token?.isEmpty ?? true) {
                    DispatchQueue.main.async {
                        self.signManger.setToken(token: result.token ?? "error token")
                        self.emailTextField.text?.removeAll()
                        self.passwordTextField.text?.removeAll()
                        self.performSegue(withIdentifier: "tabBar", sender: Any?.self)
                    }
                }
            }
        }
    }
    
    // Resize view when keyboard appear
    @objc func keyboardWillShow(sender: NSNotification) {
        let userInfo = sender.userInfo!
        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let heightConstant = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        mainViewBottomConstraint.constant = heightConstant
        // Note. that is the correct, actual value. Some prefer to use:
        // bottomConstraintForKeyboard.constant = k - bottomLayoutGuide.length
        UIView.animate(withDuration: duration) { self.view.layoutIfNeeded() }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        mainViewBottomConstraint.constant = 0
        UIView.animate(withDuration: duration) { self.view.layoutIfNeeded() }
    }

    @objc func clearKeyboard() {
        view.endEditing(true)
        // (subtle iOS bug/problem in obscure cases: see note below
        // you may prefer to add a short delay here)
    }

    func keyboardNotifications() {
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
}
