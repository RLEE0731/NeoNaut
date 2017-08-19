//
//  Neo.swift
//  Neon
//
//  Created by James Donald on 8/18/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import Foundation
import ObjectMapper

enum NeoKeys:String
{
    case balance                = "balance"
    case unspentTransactions    = "unspent"
}

public class Neo:Resource
{
    public var balance:NSNumber?    = nil
    public var unspentTransactions  = Array<Transaction>()
    
    public override func mapping(map: Map)
    {
        super.mapping(map: map)
        
        self.balance                <- map[NeoKeys.balance.rawValue]
        self.unspentTransactions    <- map[NeoKeys.unspentTransactions.rawValue]
    }
}
