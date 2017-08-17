//
//  SettingsViewController.swift
//  Neon
//
//  Created by Ronald Lee on 8/16/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController, InterfaceInitializing
{
    var tabBarImage: UIImage?
    { return #imageLiteral(resourceName: "history") }
    
    
    static func loadFromNib() -> SettingsViewController
    {
        let name = String(describing: self)
        guard let controller = UIStoryboard.settings.instantiateViewController(withIdentifier: name) as? SettingsViewController else
        { return SettingsViewController() }
        return controller
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
