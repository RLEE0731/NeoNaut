//
//  OverviewViewController.swift
//  Neon
//
//  Created by Ronald Lee on 8/16/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit

final class OverviewViewController: UIViewController, InterfaceInitializing
{
    @IBOutlet weak var refreshButton: UIBarButtonItem?
    
    var tabBarImage: UIImage?
    { return #imageLiteral(resourceName: "donut-large") }

    /// Stores the public Neo address
    var publicAddress: String = ""
    
    
    static func loadFromNib() -> OverviewViewController
    {
        let name = String(describing: self)
        guard let controller = UIStoryboard.overview.instantiateViewController(withIdentifier: name) as? OverviewViewController else
        { return OverviewViewController() }
        return controller
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = NSLocalizedString("Overview", comment: "overview")
    }
    
    
}
