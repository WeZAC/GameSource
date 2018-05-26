//
//  LoginViewController.swift
//  GameSource
//
//  Created by Ruben A Gonzalez on 4/16/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    //outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //variables
    //var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }*/

    
    
    //login function
    @IBAction func didPressLogin(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("You've logged in! Woohoo")
                self.performSegue(withIdentifier: "loginSegue", sender: sender)
            }
        }
    }
    
    //create new user
    @IBAction func didPressSignUp(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                let alert=UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
               print("You've created a new account! Woohoo")
                let newUser:[String:Any]
                newUser=["uid":Auth.auth().currentUser!.uid,"username":"","realname":"","desc":"","picRefString":"","textdist":["",""]]
                let updates:[String:Any]
                updates=[(Auth.auth().currentUser?.uid)!:newUser]
                Database.database().reference(withPath: "users").updateChildValues(updates)
                self.performSegue(withIdentifier: "signupSegue", sender: sender)
            }
            }
        }

 
    

}
