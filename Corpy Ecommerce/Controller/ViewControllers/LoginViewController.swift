//
//  LoginViewController.swift
//  Corpy Ecommerce
//
//  Created by Peter Bassem on 10/29/18.
//  Copyright © 2018 corpy. All rights reserved.
//

import UIKit
import SWSegmentedControl
import SkyFloatingLabelTextField
import UICheckbox_Swift
import Alamofire
import Toast_Swift
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var typeSegmentedControl: SWSegmentedControl!
    
    //TODO:- LoginView
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginToYourAccountLabel: UILabel!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var rememberMeButton: UICheckbox!
    @IBOutlet weak var rememberMeLabel: UILabel!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var lineSeparatorView: UIView!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var lineSeparator2View: UIView!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    //TODO:- CreateAccountView
    @IBOutlet weak var createAccountView: UIView!
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var signUpEmailTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var signUpPasswordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var signUpConfirmPasswordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var createAccountButton: UIButton!
    
    //MARK:- Properties
    var showPasswordButton: UIButton?
    var iconClick: Bool!
    var signUpShowPasswordButton: UIButton?
    var signUpIconClick: Bool!
    var signUpShowConfirmPasswordButton: UIButton?
    var signUpConfirmIconClick: Bool!
    var response: Dictionary<String, Any>? = nil
    
    var style = ToastStyle()
    
    //MARK:- Basic Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setNavigationBarItems()
        setFacebookLoginButton()
        
        if FBSDKAccessToken.current() != nil {
            print("User Already Logged in")
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "")
        navigationController?.navigationBar.backgroundColor = .red
        
        typeSegmentedControl.backgroundColor = COLORS.mainColor
        typeSegmentedControl.unselectedTitleColor = COLORS.textPrimaryColor
        typeSegmentedControl.titleColor = COLORS.textSecondaryColor
        typeSegmentedControl.indicatorColor = COLORS.textSecondaryColor
        typeSegmentedControl.font = UIFont.boldSystemFont(ofSize: 14.0)
        typeSegmentedControl.removeAllSegments()
        typeSegmentedControl.items = ["Login", "Create Account"]
        
        loginView.alpha = 1
        createAccountView.alpha = 0
        
        loginToYourAccountLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "loginToYourAccountLabel", comment: "")
        loginToYourAccountLabel.font = setFont(size: 18.0, isBold: false)
        emailTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailTextField", comment: "")
        emailTextField.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailTextField", comment: "")
        emailTextField.font = setFont(size: 17.0, isBold: false)
        emailTextField.iconImageView.image = UIImage(named: "email")
        emailTextField.iconMarginBottom = 0
        iconClick = true
        showPasswordButton = UIButton(type: .custom)
        showPasswordButton?.setImage(UIImage(named: "showpassword"), for: .normal)
        showPasswordButton?.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        showPasswordButton?.frame = CGRect(x: CGFloat(passwordTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(15), height: CGFloat(25))
        showPasswordButton?.addTarget(self, action: #selector(showPassword_Event(_:)), for: .touchUpInside)
        passwordTextField.rightView = showPasswordButton
        passwordTextField.rightViewMode = .always
        passwordTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordTextField", comment: "")
        passwordTextField.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordTextField", comment: "")
        passwordTextField.font = setFont(size: 17.0, isBold: false)
        passwordTextField.iconImageView.image = UIImage(named: "password")
        passwordTextField.iconMarginBottom = 0
        passwordTextField.isSecureTextEntry = true
        rememberMeLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "rememberMeLabel", comment: "")
        rememberMeLabel.font = setFont(size: 15.0, isBold: false)
        forgotPasswordLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "forgotPasswordLabel", comment: "")
        forgotPasswordLabel.font = setFont(size: 15.0, isBold: false)
        loginButton.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "loginButton", comment: ""), for: UIControlState.normal)
        loginButton.titleLabel?.font = setFont(size: 19.0, isBold: false)
        loginButton.setTitleColor(COLORS.textPrimaryColor, for: UIControlState.normal)
        loginButton.backgroundColor = COLORS.signButtonColor
        dontHaveAccountLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "dontHaveAccountLabel", comment: "")
        dontHaveAccountLabel.font = setFont(size: 15.0, isBold: false)
        signUpLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "signUpLabel", comment: "")
        signUpLabel.font = setFont(size: 15.0, isBold: false)
        lineSeparatorView.backgroundColor = COLORS.mainColor
        orLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "orLabel", comment: "")
        orLabel.font = setFont(size: 17.0, isBold: false)
        lineSeparator2View.backgroundColor = COLORS.mainColor
        
        firstNameTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "firstNameTextField", comment: "")
        firstNameTextField.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "firstNameTextField", comment: "")
        firstNameTextField.font = setFont(size: 17.0, isBold: false)
        firstNameTextField.iconImageView.image = UIImage(named: "name")
        firstNameTextField.iconMarginBottom = 0
        lastNameTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "lastNameTextField", comment: "")
        lastNameTextField.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "lastNameTextField", comment: "")
        lastNameTextField.font = setFont(size: 17.0, isBold: false)
        lastNameTextField.iconImageView.image = UIImage(named: "name")
        lastNameTextField.iconMarginBottom = 0
        signUpEmailTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailTextField", comment: "")
        signUpEmailTextField.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "emailTextField", comment: "")
        signUpEmailTextField.font = setFont(size: 17.0, isBold: false)
        signUpEmailTextField.iconImageView.image = UIImage(named: "email")
        signUpEmailTextField.iconMarginBottom = 0
        signUpIconClick = true
        signUpShowPasswordButton = UIButton(type: .custom)
        signUpShowPasswordButton?.setImage(UIImage(named: "showpassword"), for: .normal)
        signUpShowPasswordButton?.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        signUpShowPasswordButton?.frame = CGRect(x: CGFloat(passwordTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(15), height: CGFloat(25))
        signUpShowPasswordButton?.addTarget(self, action: #selector(signUpShowPassword_Event(_:)), for: .touchUpInside)
        signUpPasswordTextField.rightView = signUpShowPasswordButton
        signUpPasswordTextField.rightViewMode = .always
        signUpPasswordTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordTextField", comment: "")
        signUpPasswordTextField.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordTextField", comment: "")
        signUpPasswordTextField.font = setFont(size: 17.0, isBold: false)
        signUpPasswordTextField.iconImageView.image = UIImage(named: "password")
        signUpPasswordTextField.iconMarginBottom = 0
        signUpPasswordTextField.isSecureTextEntry = true
        
        signUpConfirmIconClick = true
        signUpShowConfirmPasswordButton = UIButton(type: .custom)
        signUpShowConfirmPasswordButton?.setImage(UIImage(named: "showpassword"), for: .normal)
        signUpShowConfirmPasswordButton?.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        signUpShowConfirmPasswordButton?.frame = CGRect(x: CGFloat(passwordTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(15), height: CGFloat(25))
        signUpShowConfirmPasswordButton?.addTarget(self, action: #selector(signUpShowConfirmPassword_Event(_:)), for: .touchUpInside)
        signUpConfirmPasswordTextField.rightView = signUpShowConfirmPasswordButton
        signUpConfirmPasswordTextField.rightViewMode = .always
        signUpConfirmPasswordTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirmPasswordTextField", comment: "")
        signUpConfirmPasswordTextField.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirmPasswordTextField", comment: "")
        signUpConfirmPasswordTextField.font = setFont(size: 17.0, isBold: false)
        signUpConfirmPasswordTextField.iconImageView.image = UIImage(named: "password")
        signUpConfirmPasswordTextField.iconMarginBottom = 0
        signUpConfirmPasswordTextField.isSecureTextEntry = true
        
        createAccountButton.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "createAccountButton", comment: ""), for: UIControlState.normal)
        createAccountButton.titleLabel?.font = setFont(size: 19.0, isBold: false)
        createAccountButton.setTitleColor(COLORS.textPrimaryColor, for: UIControlState.normal)
        createAccountButton.backgroundColor = COLORS.signButtonColor
        
        style.backgroundColor = COLORS.textBlackColor
        style.titleFont = setFont(size: 17.0, isBold: false)
        style.titleColor = COLORS.mainTitleLabelColor
        style.titleAlignment = NSTextAlignment.center
        
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func setFacebookLoginButton() {
        facebookLoginButton.delegate = self
        facebookLoginButton.readPermissions = ["public_profile", "email"]
    }
    
    private func getFacebookUserData() {
        if (FBSDKAccessToken.current()) != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, first_name, last_name, gender, age_range, link, locale, timezone, picture, updated_time, verified"]).start(completionHandler: { (connection, result, error) -> Void in
                if let error = error {
                    self.showMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""), message: error.localizedDescription)
                } else {
                    self.activityIndicator(isActive: true)
                    self.response = (result as! Dictionary<String, Any>)
                    guard let response = self.response else { return }
                    guard let name = response["name"] as? String else { return}
                    guard let email = response["email"] as? String else { return }
                    BaseApiRequest.socialLogin(URL: URLS.sociallogin, username: name, email: email, onCompletion: { (error, data) in
                        if let error = error {
                            self.showMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""), message: error.localizedDescription)
                            self.activityIndicator(isActive: false)
                        }
                        if let response = data {
                            guard let status = response.status else { return }
                            if status {
                                guard let user = response.data?.user else { return }
                                guard let id = user.id else { return }
                                guard let name = user.name else { return }
                                guard let email = user.email else { return }
                                guard let level = user.level else { return }
                                guard let status = user.status else { return }
                                guard let api_token = response.data?.api_token else { return }
                                VARIABELS.id = id
                                VARIABELS.name = name
                                VARIABELS.email = email
                                VARIABELS.level = level
                                VARIABELS.status = status
                                VARIABELS.api_token = api_token
                                
                                if self.rememberMeButton.isSelected {
                                    self.saveUserData(id: VARIABELS.id!, name: VARIABELS.name!, email: VARIABELS.email!, level: VARIABELS.level!, status: VARIABELS.status!, api_token: VARIABELS.api_token!)
                                }
                            }
                            self.activityIndicator(isActive: false)
                        }
                    })
                }
//                if error == nil {
//                    //everything works print the user data
//
//                }
            })
        }
    }
    
    private func saveUserData(id: Int, name: String, email: String, level: String, status: String, api_token: String) {
        VARIABELS.userPref.set(id, forKey: "user_id")
        VARIABELS.userPref.set(name, forKey: "name")
        VARIABELS.userPref.set(email, forKey: "email")
        VARIABELS.userPref.set(level, forKey: "level")
        VARIABELS.userPref.set(status, forKey: "status")
        VARIABELS.userPref.set(api_token, forKey: "api_token")
    }
    
    func checkError(arr: [String]?) -> String? {
        if let array = arr, array.count > 0 {
            return array[0]        } else {
            return nil
        }
    }
    
    //MARK:- Action Functions
    @IBAction func typeSegmentedControl_Event(_ sender: SWSegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.25) {
                self.loginView.alpha = 1
                self.createAccountView.alpha = 0
                self.firstNameTextField.resignFirstResponder()
                self.lastNameTextField.resignFirstResponder()
                self.signUpEmailTextField.resignFirstResponder()
                self.signUpPasswordTextField.resignFirstResponder()
                self.signUpConfirmPasswordTextField.resignFirstResponder()
            }
        } else if sender.selectedSegmentIndex == 1 {
            UIView.animate(withDuration: 0.25) {
                self.loginView.alpha = 0
                self.createAccountView.alpha = 1
                self.emailTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
            }
        }
    }
    
    @objc func showPassword_Event(_ sender: UIButton) {
        if iconClick {
            showPasswordButton?.setImage(UIImage(named: "hidepassword"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            iconClick = false
        } else {
            showPasswordButton?.setImage(UIImage(named: "showpassword"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            iconClick = true
        }
    }
    
    @objc func signUpShowPassword_Event(_ sender: UIButton) {
        if signUpIconClick {
            signUpShowPasswordButton?.setImage(UIImage(named: "hidepassword"), for: .normal)
            signUpPasswordTextField.isSecureTextEntry = false
            signUpIconClick = false
        } else {
            signUpShowPasswordButton?.setImage(UIImage(named: "showpassword"), for: .normal)
            signUpPasswordTextField.isSecureTextEntry = true
            signUpIconClick = true
        }
    }
    
    @objc func signUpShowConfirmPassword_Event(_ sender: UIButton) {
        if signUpConfirmIconClick {
            signUpShowConfirmPasswordButton?.setImage(UIImage(named: "hidepassword"), for: .normal)
            signUpConfirmPasswordTextField.isSecureTextEntry = false
            signUpConfirmIconClick = false
        } else {
            signUpShowConfirmPasswordButton?.setImage(UIImage(named: "showpassword"), for: .normal)
            signUpConfirmPasswordTextField.isSecureTextEntry = true
            signUpConfirmIconClick = true
        }
    }
    
    @IBAction func loginButton_Event(_ sender: UIButton) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            showMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""), message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "loginMessageError", comment: ""))
        } else {
            if isValidEmail(email: emailTextField.text!) {
                emailTextField.resignFirstResponder()
                passwordTextField.resignFirstResponder()
                self.activityIndicator(isActive: true)
                BaseApiRequest.login(URL: URLS.login, email: emailTextField.text!, password: passwordTextField.text!) { (error, data) in
                    if let error = error {
                        self.showMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""), message: error.localizedDescription)
                        self.activityIndicator(isActive: false)
                    }
                    if let response = data {
                        guard let status = response.status else { return }
                        if status {
                            guard let user = response.data?.user else { return }
                            guard let id = user.id else { return }
                            guard let name = user.name else { return }
                            guard let email = user.email else { return }
                            guard let level = user.level else { return }
                            guard let status = user.status else { return }
                            guard let api_token = response.data?.api_token else { return }
                            VARIABELS.id = id
                            VARIABELS.name = name
                            VARIABELS.email = email
                            VARIABELS.level = level
                            VARIABELS.status = status
                            VARIABELS.api_token = api_token
                            
                            if self.rememberMeButton.isSelected {
                                self.saveUserData(id: VARIABELS.id!, name: VARIABELS.name!, email: VARIABELS.email!, level: VARIABELS.level!, status: VARIABELS.status!, api_token: VARIABELS.api_token!)
                            }
                        }
                        self.activityIndicator(isActive: false)
                    }
                }
            } else {
                showMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""), message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "EnterValidEmailAndPasswordToContinue", comment: ""))
            }
        }
    }
    
    @IBAction func createAccountButton_Event(_ sender: UIButton) {
        if !firstNameTextField.hasText || !lastNameTextField.hasText || !signUpEmailTextField.hasText || !signUpPasswordTextField.hasText || !signUpConfirmPasswordTextField.hasText {
            showMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""), message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enterAllFields", comment: ""))
        } else {
            if isValidEmail(email: signUpEmailTextField.text!) {
                let name = firstNameTextField.text! + " " + lastNameTextField.text!
                guard let password = signUpPasswordTextField.text, let confirmPassword = signUpConfirmPasswordTextField.text else { return }
                guard password == confirmPassword else {
                    showMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""), message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "passwordNotMatch", comment: ""))
                    signUpPasswordTextField.text = ""
                    signUpConfirmPasswordTextField.text = ""
                    return
                }
                self.activityIndicator(isActive: true)
                BaseApiRequest.signUpUser(URL: URLS.register, name: name, email: signUpEmailTextField.text!, password: password) { (error, data) in
                    if let error = error {
                        self.showMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""), message: error.localizedDescription)
                        self.activityIndicator(isActive: false)
                    }
                    if let response = data {
                        guard let status = response.status else { return }
                        if !status {
                            guard let name = response.messages?.name?[0] else { return }
                            guard let email = response.messages?.email?[0] else { return }
                            guard let password = response.messages?.password?[0] else { return }
                            self.showMessage(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""), message: name + "\t" + email + "\t" + password)
                            self.activityIndicator(isActive: false)
                        }
                        self.activityIndicator(isActive: false)
                    }
                }
            }
        }
    }
}

// MARK:- FacebookLogin Delegate Methods
extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            showMessage(title: "Error", message: error.localizedDescription)
        } else if result.isCancelled {
            return
        } else if result.grantedPermissions.contains("email") {
            self.getFacebookUserData()
        }
    }
}
