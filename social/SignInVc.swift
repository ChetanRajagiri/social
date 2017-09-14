//
//  ViewController.swift
//  social
//
//  Created by chetan rajagiri on 13/09/17.
//  Copyright © 2017 chetan rajagiri. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftKeychainWrapper

class SignInVc: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func fbBtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("unable to authenticate fb")
            } else if result?.isCancelled == true {
                print("user cancelled fb auth")
            }else{
                print("auth done with fb")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firAuth(credential)
                
            }
        }
        
    }
    func firAuth(_ credential: AuthCredential)  {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("unable to authenticate with firebase")
            }else{
                print("Successfully authenticated with firebase")
                if let user = user {
                    let userData = ["provider" : credential.provider]
                    self.completeSigIn(id: user.uid, userData: userData)
                }
            }
        }
    }
    @IBAction func signinBtnTapped(_ sender: Any) {
        if let email = emailTxtField.text , let pwd = passwordTxtField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("email user authenticated")
                    if let user = user {
                        let userData = ["provider" : user.providerID]
                        self.completeSigIn(id: user.uid, userData: userData)
                    }
                } else
                {
                  Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                    if error != nil {
                        print("email auth cancelled")
                    } else
                    {
                        print("user created")
                        if let user = user {
                            let userData = ["provider" : user.providerID]
                            self.completeSigIn(id: user.uid, userData:userData )
                        }
                    }
                  })
                }
            })
        }
    }
    func completeSigIn(id: String, userData: Dictionary<String, String>)  {
        DataService.ds.createFirebaseDBUser(uid: id, userdata: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "GotoFeedVC", sender: nil)
    }

}














