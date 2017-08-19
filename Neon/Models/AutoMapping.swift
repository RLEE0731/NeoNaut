//
//  AutoMapping.swift
//  Neon
//
//  Created by James Donald on 8/18/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol AutoMapping: Mappable
{ }

extension AutoMapping
{
    // Copy Constructor
    internal init?(autoMapping: Self)
    {
        let data    = autoMapping.toJSON()
        let map     = Map(mappingType: .fromJSON, JSON: data)
        self.init(map: map)
        self.mapping(map: map)
    }
}
