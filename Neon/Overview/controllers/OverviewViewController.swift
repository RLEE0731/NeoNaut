//
//  OverviewViewController.swift
//  Neon
//
//  Created by Ronald Lee on 8/16/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit

final class OverviewViewController: UIViewController, InterfaceInitializing
{
    @IBOutlet weak var refreshButton: UIBarButtonItem?
    @IBOutlet weak var qrImageView: UIImageView?
    
    
    //MARK: - UI -
    var tabBarImage: UIImage?
    { return #imageLiteral(resourceName: "donut-large") }

    /// Stores the public Neo address
    var publicAddress: String = ""
    {
        didSet
        {
            if self.publicAddress.characters.count > 0
            {
                // https://www.appcoda.com/qr-code-generator-tutorial/
                let data = self.publicAddress.data(using: .isoLatin1, allowLossyConversion: false)
                guard let filter = CIFilter(name: "CIQRCodeGenerator") else
                {
                    assertionFailure("Cannot allocate CIFilter")
                    return
                }
                
                filter.setValue(data, forKey: "inputMessage")
                filter.setValue("Q", forKey: "inputCorrectionLevel")
                
                guard let qrImage = filter.outputImage else
                {
                    qrImageView?.image = nil
                    return
                }
                
                guard let imageViewFrame = self.qrImageView?.frame else
                { return }
                
                // scaling generated CIImage to imageView's frame size
                let scaleX = imageViewFrame.size.width / qrImage.extent.size.width
                let scaleY = imageViewFrame.size.height / qrImage.extent.size.height
                let resized = qrImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
                self.qrImageView?.image = UIImage(ciImage: resized)
            }
        }
    }
    
    //MARK: - Properties -
    private var wallet:Wallet?
    
    
    static func loadFromNib() -> OverviewViewController
    {
        let name = String(describing: self)
        guard let controller = UIStoryboard.overview.instantiateViewController(withIdentifier: name) as? OverviewViewController else
        { return OverviewViewController() }
        return controller
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = NSLocalizedString("Overview", comment: "overview")
        self.publicAddress = "ASWQXXFJcrWzXzAGA3vDBNA5SX6WtjqM95"
    }
    
    
    // Loads the wallet info for the given public address
    private func loadWallet(forAddress address:String)
    {
        weak var weakself = self
        NeonLightWalletDB.shared.getWallet(
            forAddress: address,
            successBlock:
            {(wallet) in
                weakself?.wallet = wallet
            },
            failureBlock:
            {(error) in
                //TODO: stuff here
            }
        )
    }
}
