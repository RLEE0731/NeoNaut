//
//  Transaction.swift
//  Neon
//
//  Created by James Donald on 8/19/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import Foundation
import ObjectMapper

enum TransactionKeys:String
{
    case gas            = "GAS"
    case neo            = "NEO"
    case blockIndex     = "block_index"
    case id             = "txid"
}

enum TransactionHistoryKeys:String
{
    case history        = "history"
}

public class Transaction:Resource
{
    private(set) public var id:String?           = nil
    private(set) public var gas:NSNumber         = 0
    private(set) public var neo:NSNumber         = 0
    private(set) public var blockIndex:NSNumber? = nil
    
    public override func mapping(map: Map)
    {
        super.mapping(map: map)
        
        self.id         <- map[TransactionKeys.id.rawValue]
        self.gas        <- map[TransactionKeys.gas.rawValue]
        self.neo        <- map[TransactionKeys.neo.rawValue]
        self.blockIndex <- map[TransactionKeys.blockIndex.rawValue]
    }
}

// Helper object for parsing a transaction history
public class TransactionHistory:Resource
{
    // The list of transactions which have occurred
    private(set) public var transactions = Array<Transaction>()
    
    public override func mapping(map: Map)
    {
        super.mapping(map: map)
        
        self.transactions <- map[TransactionHistoryKeys.history.rawValue]
    }
}
