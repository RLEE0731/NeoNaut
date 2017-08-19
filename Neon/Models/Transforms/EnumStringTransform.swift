//
//  EnumStringTransform.swift
//  Neon
//
//  Created by James Donald on 8/18/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import Foundation
import ObjectMapper

internal class EnumStringTransform<E: RawRepresentable>: TransformType where E.RawValue == String
{
    func transformFromJSON(_ value: Any?) -> E?
    {
        guard let enumString = value as? String else
        { return nil }
        
        return E(rawValue: enumString)
    }
    
    func transformToJSON(_ value:E?) -> String?
    {
        guard let enumVal = value else
        { return nil }
        
        return enumVal.rawValue
    }
}
