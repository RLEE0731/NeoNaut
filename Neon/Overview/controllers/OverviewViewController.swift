//
//  OverviewViewController.swift
//  Neon
//
//  Created by Ronald Lee on 8/16/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit

final class OverviewViewController: UIViewController
{
    //MARK: - UI
    @IBOutlet weak var refreshButton:       UIBarButtonItem?
    @IBOutlet weak var qrImageView:         UIImageView?
    @IBOutlet weak var publicAddressButton: UIButton?
    @IBOutlet weak var neoValueLabel:       UILabel?
    @IBOutlet weak var gasValueLabel:       UILabel?
    @IBOutlet weak var claimButton:         UIButton?
    
    
    var tabBarImage: UIImage?
    { return #imageLiteral(resourceName: "donut-large") }

    //MARK: - Properties
    private var wallet:Wallet?
    {
        didSet
        {
            guard let neoBalance = wallet?.neo?.balance,
                let gasBalance = wallet?.gas?.balance else
            { return }
            self.neoValueLabel?.text = "\(neoBalance)"
            self.gasValueLabel?.text = "\(gasBalance)"
        }
    }
    
    
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
        self.resetUI()
        self.loadWallet()
        NotificationCenter.default.addObserver(forName: NSNotification.Name.didSavePublicAddress,
                                               object: nil,
                                               queue: nil,
                                               using:
            { [weak self] (notification) in
                self?.resetUI()
                if let pubAddress = UserDefaults.standard.value(forKey: .neoPublicAddress) as? String
                {
                    self?.publicAddressButton?.setTitle(pubAddress, for: .normal)
                    self?.qrImageView?.setImage(withQRCode: pubAddress)
                }
                self?.loadWallet()
        })
    }
    
    
    // Loads the wallet info for the given public address
    private func loadWallet()
    {
        guard let address = UserDefaults.standard.value(forKey: .neoPublicAddress) as? String else
        { return }
        
        NeonLightWalletDB.shared.getWallet(
            forAddress: address,
            successBlock:
            {[weak self] (wallet) in
                self?.wallet = wallet
            },
            failureBlock:
            {[weak self] (error) in
                let alert = UIAlertController(title: error?.localizedDescription,
                                              message: nil,
                                              cancel: nil,
                                              preferredStyle: .alert)
                self?.present(alert, animated: true, completion: nil)
            }
        )
    }
}


extension OverviewViewController: InterfaceInitializing
{
    func resetUI()
    {
        self.title = NSLocalizedString("Overview", comment: "overview")
        
        self.claimButton?.setTitleColor(.neonLogo, for: .normal)
        self.claimButton?.layer.cornerRadius = 3
        self.claimButton?.layer.borderWidth = 3
        self.claimButton?.layer.borderColor = UIColor.neonLogo.cgColor
        
        self.publicAddressButton?.setTitle("--", for: .normal)
        self.qrImageView?.setImage(withQRCode: "")
        self.neoValueLabel?.text = "--"
        self.gasValueLabel?.text = "--"
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
            { (action) in
                guard let address = UserDefaults.standard.value(forKey: .neoPublicAddress) as? String else
                { return }
                UIPasteboard.general.string = address
        })
        alert.addAction(copyAction)
    }
}


//MARK: - Claming GAS
extension OverviewViewController
{
    @IBAction func claimAction(_ sender: UIButton)
    {
        self.claimGas()
    }
    
    
    func claimGas()
    {
        //TODO: claim gas
    }
}
