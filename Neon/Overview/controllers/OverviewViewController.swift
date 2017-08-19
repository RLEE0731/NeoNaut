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
    //MARK: - UI -
    var tabBarImage: UIImage?
    { return #imageLiteral(resourceName: "donut-large") }
    
    //MARK: - Properties -
    private var wallet:Wallet?
    
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
        self.title = "Overview"
    }
    
    // Loads the wallet info for the given public address
    private func loadWallet(forAddress address:String)
    {
        weak var weakself = self
        NeonLightWalletDB.shared.getWallet(
            forAddress: address,
            successBlock:
            {(wallet) in
                weakself?.wallet = wallet
            },
            failureBlock:
            {(error) in
                //TODO: stuff here
            }
        )
    }
}
