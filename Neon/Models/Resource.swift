//
//  Resource.swift
//  Neon
//
//  Created by James Donald on 8/18/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import Foundation
import ObjectMapper

enum ResourceKeys:String
{
    case defaultKey = "ResourceObjectDefaultKey"
}

public class Resource: NSObject, NSCoding, AutoMapping
{
    public required init?(map: Map)
    { /** Do nothing for now */ }
    
    public func mapping(map: Map)
    { /** Nothing by default */ }
    
    // auto encoder which is used for
    public required init?(coder aDecoder: NSCoder)
    {
        super.init()
        
        guard let encoded = aDecoder.decodeObject(forKey: ResourceKeys.defaultKey.rawValue) as? [String:Any] else
        { return nil }
        
        // save the data into self
        _ = Mapper().map(JSON: encoded, toObject: self)
    }
    
    public func encode(with aCoder: NSCoder)
    {
        let json = self.toJSON()
        aCoder.encode(json, forKey: ResourceKeys.defaultKey.rawValue)
    }
}
