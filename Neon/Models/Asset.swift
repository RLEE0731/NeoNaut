//
//  Asset.swift
//  Neon
//
//  Created by James Donald on 8/18/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import Foundation
import ObjectMapper

enum AssetKeys:String
{
    case index  = "index"
    case id     = "txid"
    case value  = "value"
}

public class Asset: Resource
{
    private(set) public var index:NSNumber?  = nil
    private(set) public var id:String?       = nil
    private(set) public var value:NSNumber?  = nil
    
    public override func mapping(map: Map)
    {
        super.mapping(map: map)
        
        self.id     <- map[AssetKeys.id.rawValue]
        self.index  <- map[AssetKeys.index.rawValue]
        self.value  <- map[AssetKeys.value.rawValue]
    }
}
