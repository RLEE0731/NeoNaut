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
}


extension InterfaceInitializing where Self: UIViewController
{
    static func loadFromNib() -> Self
    {
        return self._genericLoadFromNib()
    }
    
    static private func _genericLoadFromNib<T: UIViewController>() -> T
    {
        let nibname = String(describing: T.self)
        return T(nibName: nibname, bundle: nil)
    }
}
