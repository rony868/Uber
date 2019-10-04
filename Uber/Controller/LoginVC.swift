//
//  LoginVC.swift
//  Uber
//
//  Created by MD RASHEDUZZAMAN on 11/04/19.
//  Copyright © 2019 MD RASHEDUZZAMAN. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate, Alertable {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var authBtn: RoundedShadowButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        view.bindToKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleScreenTap(){
        self.view.endEditing(true)
    
    }
    
    @IBAction func CancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func authBtnWasPressed(_ sender: Any) {
//        if emailField.text != nil && passwordField.text != nil {
//            authBtn.animateButton(shouldLoad: true, withMessage: nil)
//        }
        
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    if let user = user {
                        if self.segmentedControl.selectedSegmentIndex == 0 {
                            let userData = ["provider": user.user.providerID] as [String: Any]
                            DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: false)
                            
                        } else {
                            let userData = ["provider": user.user.providerID, "userIsDriver": true,"isPickupModeEnabled": false, "driverIsOnTrip": false] as [String: Any]
                        DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: true)
                        }
                    }
                    print("Email user authenticated successfully with Firebase")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    if let errorCode = AuthErrorCode(rawValue: error!._code) {
                        switch errorCode {
                        case .networkError:
                            self.showAlert("Network problem")
                        case .emailAlreadyInUse:
                            self.showAlert("Email already in used. Try with other")
                        case .invalidEmail:
                            self.showAlert("Email is not currect, try again")
                        case .wrongPassword:
                            self.showAlert("You have enterd wrong password")
                        default:
                            self.showAlert("unexpectd error occurred")
                        }
                    }
                    
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            if let errorCode = AuthErrorCode(rawValue: error!._code){
                                switch errorCode {
                                case .emailAlreadyInUse:
                                    self.showAlert("What eamil is already in use. Please try with other")
                                case .invalidEmail:
                                    self.showAlert("That is an invalid email! Please try with the currect.")
                                default:
                                    self.showAlert("An unexpected error occured.")
                                }
                            }
                        } else {
                            if let user = user {
                                if self.segmentedControl.selectedSegmentIndex == 0 {
                                    let userData = ["provider": user.user.providerID] as [String: Any]
                                    DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: false)
                                } else {
                                    let userData = ["provider": user.user.providerID, "userIsDriver": true, "isPickupModeEnabled": false, "driverIsOnTrip": false] as [String: Any]
                                    DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: true)
                                }
                            }
                            print("Successfully created a new user with Firebase")
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                }
            }
        }
    }    
}
