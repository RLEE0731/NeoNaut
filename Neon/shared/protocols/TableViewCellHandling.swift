//
//  TableViewCellHandling.swift
//  Neon
//
//  Created by Ronald Lee on 8/21/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit


protocol TableViewCellHandling
{
    static var cellIdentifier: String { get }
    
    static func register(withTableView tableView: UITableView?)
    func setup(withData data: Any?, tableView: UITableView, at indexPath: IndexPath)
}


extension TableViewCellHandling where Self: UITableViewCell
{
    static var cellIdentifier: String
    { return String(describing: self) }
    
    
    static func register(withTableView tableView: UITableView?)
    {
        let identifier = self.cellIdentifier
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: identifier)
    }
}
