//
//  TabBarController.swift
//  Neon
//
//  Created by Ronald Lee on 8/15/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController
{
    var isLoggedIn = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        guard self.isLoggedIn else
        {
            let login = LoginViewController.loadFromNib()
            login.delegate = self
            self.present(login, animated: true, completion: nil)
            return
        }
        
    }
}


extension TabBarController: LoginViewControllerDelegate
{
    func loginViewController(controller: LoginViewController, didLogin: Bool)
    {
        self.isLoggedIn = didLogin
        self.dismiss(animated: true, completion: nil)
    }
}
