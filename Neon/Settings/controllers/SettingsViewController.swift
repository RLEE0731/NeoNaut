//
//  SettingsViewController.swift
//  Neon
//
//  Created by Ronald Lee on 8/16/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit


protocol SettingsViewControllerDelegate: class
{
    func SettingsViewControllerWillLogout(viewcontroller: SettingsViewController)
}


final class SettingsViewController: UIViewController, InterfaceInitializing
{
    weak var delegate: SettingsViewControllerDelegate?
    var tabBarImage: UIImage?
    { return #imageLiteral(resourceName: "settings") }
    
    
    static func loadFromNib() -> SettingsViewController
    {
        let name = String(describing: self)
        guard let controller = UIStoryboard.settings.instantiateViewController(withIdentifier: name) as? SettingsViewController else
        { return SettingsViewController() }
        return controller
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    @IBAction func logoutAction(_ sender: Any)
    {
        self.delegate?.SettingsViewControllerWillLogout(viewcontroller: self)
    }
}


#if DEBUG
//MARK: - Shake handler
extension SettingsViewController
{
    override var canBecomeFirstResponder: Bool
    { return true }
    
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        guard motion == .motionShake else
        { return }
        
        // detected shake, bring up debug
        let alert = UIAlertController(title: "What's shakin?", message: nil, cancel: "OK", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}
#endif
