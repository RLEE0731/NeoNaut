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
    var isLoggedIn: Bool
    { return UserDefaults.standard.value(forKey: .neoPublicAddress) != nil }
    
    var historyVC:      HistoryViewController?
    var overviewVC:     OverviewViewController?
    var settingsVC:     SettingsViewController?

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupControllers()
    }

    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        guard self.isLoggedIn else
        {
            self.showLogin()
            return
        }   
    }
    
    
    func showLogin()
    {
        let login = LoginViewController.loadFromNib()
        login.delegate = self
        self.present(login, animated: true, completion: nil)
    }
    
    
    func setupControllers()
    {
        let overview = OverviewViewController.loadFromNib()
        overview.tabBarItem.image = overview.tabBarImage
        self.overviewVC = overview
        
        let history = HistoryViewController.loadFromNib()
        history.tabBarItem.image = history.tabBarImage
        self.historyVC = history
        
        let settings = SettingsViewController.loadFromNib()
        settings.delegate = self
        settings.tabBarItem.image = settings.tabBarImage
        self.settingsVC = settings

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
    func loginViewController(controller: LoginViewController, didLoginWithPublicAddress publicAddress: String)
    {
        UserDefaults.standard.set(value: publicAddress, forKey: .neoPublicAddress)
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: - Delegate: settings
extension TabBarController: SettingsViewControllerDelegate
{
    func SettingsViewControllerWillLogout(viewcontroller: SettingsViewController)
    {
        //clear user defaults, show login
        UserDefaults.standard.set(value: nil, forKey: .neoPublicAddress)
        self.selectedIndex = 0
        self.showLogin()
    }
}
