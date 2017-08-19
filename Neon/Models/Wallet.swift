//
//  Wallet.swift
//  Neon
//
//  Created by James Donald on 8/18/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import Foundation
import ObjectMapper

enum WalletKeys:String
{
    case neo        = "NEO"
    case gas        = "GAS"
    case address    = "address"
    case net        = "net"
}

public class Wallet: Resource
{
    public var neo:Neo?         = nil
    public var gas:Gas?         = nil
    public var address:String?  = nil
    public var net:Net?         = nil
    
    public override func mapping(map: Map)
    {
        super.mapping(map: map)
        
        self.neo        <- map[WalletKeys.neo.rawValue]
        self.gas        <- map[WalletKeys.gas.rawValue]
        self.address    <- map[WalletKeys.address.rawValue]
        self.net        <- (map[WalletKeys.net.rawValue], EnumStringTransform())
    }
}
