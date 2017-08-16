//
//  HistoryViewController.swift
//  Neon
//
//  Created by Ronald Lee on 8/16/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit


final class HistoryViewController: UIViewController, InterfaceInitializing
{
    static func loadFromNib() -> HistoryViewController
    {
        let name = String(describing: self)
        guard let controller = UIStoryboard.history.instantiateViewController(withIdentifier: name) as? HistoryViewController else
        { return HistoryViewController() }
        return controller
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
