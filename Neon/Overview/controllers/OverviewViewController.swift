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
    @IBOutlet weak var refreshButton:       UIBarButtonItem?
    @IBOutlet weak var qrImageView:         UIImageView?
    @IBOutlet weak var publicAddressButton: UIButton?
    
    
    //MARK: - UI
    var tabBarImage: UIImage?
    { return #imageLiteral(resourceName: "donut-large") }

    /// Stores the public Neo address
    var publicAddress: String = ""
    {
        didSet
        {
            self.publicAddressButton?.setTitle(self.publicAddress, for: .normal)
            self.qrImageView?.setImage(withQRCode: self.publicAddress)
        }
    }
    
    
    //MARK: - Properties
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


//MARK: - Public address actions
extension OverviewViewController
{
    @IBAction func publicAddressAction(_ sender: UIButton)
    {
        let options = UIAlertController(title: nil,
                                        message: nil,
                                        cancel: NSLocalizedString("Cancel", comment: "cancel"),
                                        preferredStyle: .actionSheet)
        
        options.popoverPresentationController?.sourceView = sender
        self.handleCopy(alert: options)
        self.present(options, animated: true, completion: nil)
    }
    
    
    func handleCopy(alert: UIAlertController)
    {
        let copyAction = UIAlertAction(title: NSLocalizedString("Copy", comment: "copy"),
                                       style: .default,
                                       handler:
            { [weak self] (action) in
                UIPasteboard.general.string = self?.publicAddress
        })
        alert.addAction(copyAction)
    }
}
