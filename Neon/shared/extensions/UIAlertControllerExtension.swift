//
//  UIAlertControllerExtension.swift
//  Neon
//
//  Created by Ronald Lee on 8/17/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit


extension UIAlertController
{
    /// Convenience initializer with Cancel action
    convenience init(title: String?, message: String?, cancel: String?, preferredStyle: UIAlertControllerStyle)
    {
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        let cancelAction = UIAlertAction(title: cancel ?? NSLocalizedString("Cancel", comment: "cancel"),
                                         style: .cancel,
                                         handler: nil)
        self.addAction(cancelAction)
    }
}
