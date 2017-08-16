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
    func loginViewController(controller: LoginViewController, didLogin: Bool)
}


final class LoginViewController: UIViewController, InterfaceInitializing
{
    weak var delegate: LoginViewControllerDelegate?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func dismissAction(_ sender: Any)
    {
        self.delegate?.loginViewController(controller: self, didLogin: true)
    }
}
