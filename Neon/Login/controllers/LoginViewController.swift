//
//  LoginViewController.swift
//  Neon
//
//  Created by Ronald Lee on 8/15/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit


protocol LoginViewControllerDelegate: class
{
    func loginViewController(controller: LoginViewController, didLoginWithPublicAddress publicAddress: String)
}


final class LoginViewController: UIViewController
{
    @IBOutlet weak var logoLabel:       UILabel?
    @IBOutlet weak var textField:       UITextField?
    @IBOutlet weak var loginButton:     UIButton?
    @IBOutlet weak var newButton:       UIButton?
    @IBOutlet weak var cameraButton:    UIButton?
    
    weak var delegate: LoginViewControllerDelegate?

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.resetUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.textField?.becomeFirstResponder()
    }
    
    
    @IBAction func cameraAction(_ sender: UIButton)
    {
        //TODO: QR Reader
        let qrReader = QRReaderViewController.loadFromNib()
        qrReader.delegate = self
        let nav = UINavigationController(rootViewController: qrReader)
        self.present(nav, animated: true, completion: nil)
    }
    
    
    @IBAction func loginAction(_ sender: Any)
    {
        guard let key = self.textField?.text else
        { return }
        //TODO: login network call
        self.delegate?.loginViewController(controller: self, didLoginWithPublicAddress: key)
    }
    
    
    @IBAction func newAction(_ sender: UIButton)
    {
        //TODO: new wallet network call
    }
}


//MARK: - InterfaceInitializing
extension LoginViewController: InterfaceInitializing
{
    func resetUI()
    {
        self.title = NSLocalizedString("Login", comment: "login")
        
        self.logoLabel?.text        = NSLocalizedString("iNEO", comment: "app name")
        self.logoLabel?.textColor   = .neonLogo
        
        if let loginBtn = self.loginButton
        {
            loginBtn.layer.cornerRadius = 5
            loginBtn.layer.borderWidth  = 1
            loginBtn.layer.borderColor  = loginBtn.tintColor.cgColor
        }
        
        if let newBtn = self.newButton
        {
            newBtn.layer.cornerRadius   = 5
            newBtn.layer.borderWidth    = 1
            newBtn.tintColor            = UIColor.neonLogo
            newBtn.layer.borderColor    = UIColor.neonLogo.cgColor
        }
    }
}


//MARK: - Delegate: uitextfield
extension LoginViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //TODO: ensure textfield is not empty, then perform login
        self.loginAction(self)
        textField.resignFirstResponder()
        return true
    }
}


extension LoginViewController: QRReaderViewControllerDelegate
{
    func QRReaderViewControllerDidDismiss(viewController: QRReaderViewController)
    {
        self.textField?.text = viewController.qrCode
        self.dismiss(animated: true, completion: nil)
    }
}
