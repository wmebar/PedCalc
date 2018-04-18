//
//  LoginViewController.swift
//  PedCalc
//
//  Created by Wagner Barbosa on 08/04/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    let swiftLocale: Locale = Locale.current

    @IBOutlet weak var signinSelector: UISegmentedControl!
    
    @IBOutlet weak var signinLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    //Google Login Outlets
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var statusText: UILabel!
    
    var segmentControlLoginRegisterReset:Int = 0
    
    //var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        let googleService = NSDictionary(contentsOfFile: path!)!
        GIDSignIn.sharedInstance().clientID = googleService.object(forKey: "CLIENT_ID") as! String
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.login")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.me")
        // Sign in automatically
        GIDSignIn.sharedInstance().signInSilently()
        // Something to do with notifications
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LoginViewController.receiveToggleAuthUINotification(_:)),
                                               name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                               object: nil)

        statusText.text = "Initialized Swift app..."
        toggleAuthUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        toggleAuthUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func resetUserDafault() {
        
        let userDefaults = UserDefaults.standard
        
        let dict = UserDefaults.standard.dictionaryRepresentation()
        
        for key in dict.keys {
            
            //GoogleSignIn take this key to check previous signin status
            
            if key == "GID_AppHasRunBefore"{
                
                continue
                
            }
            
            userDefaults.removeObject(forKey: key);
            
        }
        
        UserDefaults.standard.synchronize()
        
    }
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        
        // Check the bool and set the button and labels
        segmentControlLoginRegisterReset = self.signinSelector.selectedSegmentIndex //== 0
        signinLabel.text = self.signinSelector.titleForSegment(at:segmentControlLoginRegisterReset )//"Sign In"//"Register"
        signinButton.setTitle(signinLabel.text, for: .normal)
        

        
    }
    
    
    
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
        
        // TODO: Do some form validation on the email and password
        
        //if let email = emailTextField.text, let pass = passwordTextField.text {
        if let email = emailTextField.text {
            // Check if it's sign in or register
            switch segmentControlLoginRegisterReset {
            case 0:
                if let pass = passwordTextField.text {
                    Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                        
                        // Check that user isn't nil
                        if let u = user {
                            // User is found, go to home screen
                            self.performSegue(withIdentifier: "goToHome", sender: self)
                        }
                        else {
                            // Error: check error and show message
                            if error != nil {
                                self.errorLabel.isHidden = false
                                
                                self.errorLabel.text = error?.localizedDescription
                                
                                
                            }
                            print(error)
                        }
                    }
                }
            case 1:
                if let pass = passwordTextField.text {
                    Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                        
                        // Check that user isn't nil
                        if let u = user {
                            // User is found, go to home screen
                            self.performSegue(withIdentifier: "goToHome", sender: self)
                        }
                        else {
                            // Error: check error and show message
                        }
                        
                    }
                }
            case 2:
                // [START action_code_settings]
                let actionCodeSettings = ActionCodeSettings()
                actionCodeSettings.url = URL(string: "https://bfvs3.app.goo.gl")
                // The sign-in operation has to always be completed in the app.
                actionCodeSettings.handleCodeInApp = true
                actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
                actionCodeSettings.setAndroidPackageName("com.example.android",
                                                         installIfNotAvailable: false, minimumVersion: "12")
                // [END action_code_settings]
                // [START send_signin_link]
                Auth.auth().sendSignInLink(toEmail:email,
                                           actionCodeSettings: actionCodeSettings) { error in
                                            // [START_EXCLUDE]
                                            // [END_EXCLUDE]
                                            if let error = error {
                                                //self.showMessagePrompt(error.localizedDescription)
                                                return
                                            }
                                            // The link was successfully sent. Inform the user.
                                            // Save the email locally so you don't need to ask the user for it again
                                            // if they open the link on the same device.
                                            UserDefaults.standard.set(email, forKey: "Email")
                                            //self.showMessagePrompt("Check your email for link")
                                            // [START_EXCLUDE]
                                            // [END_EXCLUDE]
                }
                // [END send_signin_link]
            default:
                break
            }

        }
        
        
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        // [START_EXCLUDE silent]
        statusText.text = "Signed out."
        toggleAuthUI()
        // [END_EXCLUDE]
    }
    
    
    @IBAction func didTapGoogleLogIn(_ sender: GIDSignInButton) {
        toggleAuthUI()
    }
    
    @IBAction func didTapDisconnect(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().disconnect()
        // [START_EXCLUDE silent]
        statusText.text = "Disconnecting."
        // [END_EXCLUDE]
    }
    func toggleAuthUI() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            // Signed in
            signInButton.isHidden = true
            signOutButton.isHidden = false
            disconnectButton.isHidden = false
            self.performSegue(withIdentifier: "goToHome", sender: self)
            
        } else {
            signInButton.isHidden = false
            signOutButton.isHidden = true
            disconnectButton.isHidden = true
            statusText.text = "Google Sign in\niOS Demo"
            //self.performSegue(withIdentifier: "goToHome", sender: self)
            
        }
    }
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if let err = error {
            print(err)
        }
        else {
            self.performSegue(withIdentifier: "goToHome", sender: self)
            
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                                  object: nil)
    }
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                guard let userInfo = notification.userInfo as? [String:String] else {return}
                self.statusText.text = userInfo["statusText"]!
                
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
