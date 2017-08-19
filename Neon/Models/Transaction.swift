//
//  Transaction.swift
//  Neon
//
//  Created by James Donald on 8/18/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import Foundation
import ObjectMapper

enum TransactionKeys:String
{
    case index  = "index"
    case id     = "txid"
    case value  = "value"
}

public class Transaction: Resource
{
    public var index:NSNumber?  = nil
    public var id:String?       = nil
    public var value:NSNumber?  = nil
    
    public override func mapping(map: Map)
    {
        super.mapping(map: map)
        
        self.id     <- map[TransactionKeys.id.rawValue]
        self.index  <- map[TransactionKeys.index.rawValue]
        self.value  <- map[TransactionKeys.value.rawValue]
    }
}
