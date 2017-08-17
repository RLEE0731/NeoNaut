//
//  InterfaceInitializing.swift
//  Neon
//
//  Created by Ronald Lee on 8/15/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit


protocol InterfaceInitializing
{
    static func loadFromNib() -> Self
    var tabBarImage: UIImage? { get }
}


extension InterfaceInitializing where Self: UIViewController
{
    var tabBarImage: UIImage?
    { return nil }
    
    
    static func loadFromNib() -> Self
    {
        return self._genericLoadFromNib()
    }
    
    
    static private func _genericLoadFromNib<T>() -> T where T: UIViewController
    {
        let nibname = String(describing: T.self)
        let allocated = T(nibName: nibname, bundle: nil)
        return allocated
    }
}
