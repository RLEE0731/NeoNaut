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
    /// List of keys handled by the app
    enum UserDefaultsKey: String
    {
        case neoPublicAddress
    }
    
    
    func set(value: Any?, forKey key: UserDefaultsKey)
    {
        self.set(value, forKey: key.rawValue)
        self.broadcastChange(onKey: key)
    }
    
    
    func value(forKey key: UserDefaultsKey) -> Any?
    {
        return self.value(forKey: key.rawValue)
    }
    
    
    fileprivate func broadcastChange(onKey key: UserDefaultsKey)
    {
        let center = NotificationCenter.default
        
        switch key
        {
        case .neoPublicAddress:
            center.post(name: NSNotification.Name.didSavePublicAddress, object: nil)
        }
    }
}
