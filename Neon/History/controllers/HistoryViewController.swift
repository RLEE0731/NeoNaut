//
//  HistoryViewController.swift
//  Neon
//
//  Created by Ronald Lee on 8/16/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit


final class HistoryViewController: UIViewController
{
    //MARK: - UI -
    @IBOutlet weak var tableView: UITableView?
    
    //MARK: - Properties -
    var tabBarImage: UIImage?
    { return #imageLiteral(resourceName: "history") }
    
    fileprivate var transactions:Array<Transaction> = []
    {
        didSet
        { self.tableView?.reloadData() }
    }
    
    
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
        TransactionCell.register(withTableView: self.tableView)
        self.resetUI()
        self.loadTransactions()
        NotificationCenter.default.addObserver(forName: NSNotification.Name.didSavePublicAddress,
                                               object: nil,
                                               queue: nil,
                                               using:
            { [weak self] (notification) in
                self?.loadTransactions()
        })
    }
    
    
    /// Loads the list of transactions for the given address
    private func loadTransactions()
    {
        guard let publicAddress = UserDefaults.standard.value(forKey: .neoPublicAddress) as? String else
        { return }
        
        NeonLightWalletDB.shared.getTransactions(
            forAddress: publicAddress,
            successBlock:
            { [weak self] (transactions) in
                self?.transactions = transactions
            },
            failureBlock:
            { (error) in
                assertionFailure("\(String(describing: error))")
            }
        )
    }
}


extension HistoryViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        tableView.separatorStyle = (self.transactions.count > 0) ? .singleLine : .none
        return self.transactions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let transactionCell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.cellIdentifier, for: indexPath) as? TransactionCell
        transactionCell?.setup(withData: self.transactions[indexPath.row], tableView: tableView, at: indexPath)
        return transactionCell ?? UITableViewCell()
    }
}


extension HistoryViewController: UITableViewDelegate
{
    
}


extension HistoryViewController: InterfaceInitializing
{
    func resetUI()
    {
        self.title = NSLocalizedString("Transactions", comment: "transactions")
    }
}
