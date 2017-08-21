//
//  InterfaceInitializing.swift
//  Neon
//
//  Created by Ronald Lee on 8/15/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit


/** 
 Handling Xib/Storyboard-based allocations
 */
protocol InterfaceInitializing
{
    var tabBarImage: UIImage? { get }
    
    static func loadFromNib() -> Self
    
    /// Used to handle post-creation UI setup (default color, localization, default/empty values)
    func resetUI()
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
    
    
    func resetUI()
    {}
}
