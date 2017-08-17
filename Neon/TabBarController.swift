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
    
    
    func setupControllers()
    {
        let overview = OverviewViewController.loadFromNib()
        overview.tabBarItem.image = overview.tabBarImage
        
        let history = HistoryViewController.loadFromNib()
        history.tabBarItem.image = history.tabBarImage
        
        let settings = SettingsViewController.loadFromNib()
        settings.tabBarItem.image = settings.tabBarImage

        self.viewControllers =
            [
                UINavigationController(rootViewController: overview),
                UINavigationController(rootViewController: history),
                UINavigationController(rootViewController: settings)
        ]
    }
}


//MARK: - Delegate: login
extension TabBarController: LoginViewControllerDelegate
{
    func loginViewController(controller: LoginViewController, didLogin: Bool)
    {
        self.isLoggedIn = didLogin
        self.setupControllers()
        self.dismiss(animated: true, completion: nil)
    }
}
