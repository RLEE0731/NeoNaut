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
    //MARK: - UI -
    var tabBarImage: UIImage?
    { return #imageLiteral(resourceName: "history") }
    
    //MARK: - Properties -
    private var transactions:Array<Transaction> = []
    
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
    
    /// Loads the list of transactions for the given address
    private func loadTransactions(forAddress address:String)
    {
        weak var weakself = self
        NeonLightWalletDB.shared.getTransactions(
            forAddress: address,
            successBlock:
            {(transactions) in
                weakself?.transactions = transactions
            },
            failureBlock:
            {(error) in
                // do something here lol
            }
        )
    }
}
