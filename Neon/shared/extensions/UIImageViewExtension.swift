//
//  UIImageViewExtension.swift
//  Neon
//
//  Created by Ronald Lee on 8/19/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit
import CoreImage


extension UIImageView
{
    // Adopted from https://www.appcoda.com/qr-code-generator-tutorial/
    @discardableResult
    func setImage(withQRCode qrCode: String) -> Bool
    {
        //TODO: Not use string literals in code
        let data = qrCode.data(using: .isoLatin1, allowLossyConversion: false)
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else
        {
            assertionFailure("Cannot allocate CIFilter")
            return false
        }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
        
        guard let qrImage = filter.outputImage else
        {
            self.image = nil
            return false
        }
        
        // scaling generated CIImage to imageView's frame size
        let scaleX = self.frame.size.width / qrImage.extent.size.width
        let scaleY = self.frame.size.height / qrImage.extent.size.height
        let resized = qrImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        self.image = UIImage(ciImage: resized)
        return true
    }
}

