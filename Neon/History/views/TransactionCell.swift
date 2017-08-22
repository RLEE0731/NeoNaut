//
//  TransactionCell.swift
//  Neon
//
//  Created by Ronald Lee on 8/21/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit


class TransactionCell: UITableViewCell, TableViewCellHandling
{
    @IBOutlet weak var cellTitleLabel:  UILabel?
    @IBOutlet weak var cellDetailLabel: UILabel?
    @IBOutlet weak var cellCoinLabel:   UILabel?
    
    
    func setup(withData data: Any?, tableView: UITableView, at indexPath: IndexPath)
    {
        guard let transaction = data as? Transaction else
        { return }
        
        self.cellDetailLabel?.text = transaction.id
        
        // handle neo
        if transaction.neo != 0
        {
            self.cellTitleLabel?.text = "\(transaction.neo)"
            self.cellCoinLabel?.text = "NEO"
            self.cellTitleLabel?.textColor = (transaction.neo.doubleValue < 0) ? .red : .black
        }
        else // handle gas
        {
            self.cellTitleLabel?.text = "\(transaction.gas)"
            self.cellCoinLabel?.text = "GAS"
            self.cellTitleLabel?.textColor = (transaction.gas.doubleValue < 0) ? .red : .black
        }
    }
    
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.cellTitleLabel?.text = "--"
        self.cellDetailLabel?.text = "--"
    }
}
