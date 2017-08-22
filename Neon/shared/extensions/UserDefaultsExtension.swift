//
//  UserDefaultsExtension.swift
//  Neon
//
//  Created by Ronald Lee on 8/21/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import Foundation


extension UserDefaults
{
    enum UserDefaultsKey: String
    {
        case neoPublicAddress = "neoPublicAddress"
    }
    
    
    func set(value: Any?, forKey key: UserDefaultsKey)
    {
        self.set(value, forKey: key.rawValue)
    }
    
    
    func value(forKey key: UserDefaultsKey) -> Any?
    {
        return self.value(forKey: key.rawValue)
    }
}
