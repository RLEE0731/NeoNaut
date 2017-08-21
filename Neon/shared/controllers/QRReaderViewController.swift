//
//  QRReaderViewController.swift
//  Neon
//
//  Created by Ronald Lee on 8/19/17.
//  Copyright © 2017 CityOfZion. All rights reserved.
//

import UIKit
import AVFoundation


protocol QRReaderViewControllerDelegate: class
{
    func QRReaderViewControllerDidDismiss(viewController: QRReaderViewController)
}


final class QRReaderViewController: UIViewController
{
    @IBOutlet weak var avContainer:     UIView?
    @IBOutlet weak var focusView:       UIView?
    @IBOutlet weak var demoQRContainer: UIView?
    @IBOutlet weak var demoQRImageView: UIImageView?
    
    var qrCode:             String?
    var captureSession:     AVCaptureSession?
    var videoPreviewLayer:  AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:    UIView?
    weak var delegate:      QRReaderViewControllerDelegate?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.resetUI()
        self.startCapturing()
    }
    
    
    @IBAction func cancelAction(_ sender: Any)
    { self.delegate?.QRReaderViewControllerDidDismiss(viewController: self) }
    
    
    func startCapturing()
    {
        // taken from https://www.appcoda.com/barcode-reader-swift/
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do
        {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            let mCaptureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            mCaptureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            mCaptureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            if let mVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: mCaptureSession),
                let avContainer = self.avContainer
            {
                mVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                mVideoPreviewLayer.frame = avContainer.layer.bounds
                avContainer.layer.addSublayer(mVideoPreviewLayer)
                self.videoPreviewLayer = mVideoPreviewLayer
            }
            
            // Start video capture.
            mCaptureSession.startRunning()
            
            self.captureSession = mCaptureSession
        }
        catch
        { assertionFailure(error.localizedDescription) }
    }
}


//MARK: - Delegate: av capture
extension QRReaderViewController: AVCaptureMetadataOutputObjectsDelegate
{
    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputMetadataObjects metadataObjects: [Any]!,
                       from connection: AVCaptureConnection!)
    {
        guard metadataObjects != nil,
            metadataObjects.count > 0,
            let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            metadataObj.type == AVMetadataObjectTypeQRCode,
            let qrString = metadataObj.stringValue,
            qrString.characters.count > 0
            else
        { return }

        self.captureSession?.stopRunning()
        self.qrCode = qrString
        self.delegate?.QRReaderViewControllerDidDismiss(viewController: self)

    }
}


//MARK: - InterfaceInitializing
extension QRReaderViewController: InterfaceInitializing
{
    func resetUI()
    {
        self.title = NSLocalizedString("QR Reader", comment: "QR Reader")
        
        self.avContainer?.layer.masksToBounds = false
        self.avContainer?.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.avContainer?.layer.shadowRadius = 3
        self.avContainer?.layer.shadowOpacity = 0.5

        let borderWidth: CGFloat = 3
        
        self.focusView?.layer.borderWidth = borderWidth
        self.focusView?.layer.borderColor = UIColor.neonLogo.cgColor
        self.focusView?.layer.cornerRadius = borderWidth
        
        self.demoQRContainer?.layer.borderWidth = borderWidth
        self.demoQRContainer?.layer.borderColor = UIColor.neonLogo.cgColor
        self.demoQRContainer?.layer.cornerRadius = borderWidth
        
        self.demoQRImageView?.setImage(withQRCode: "sample qr code")
        
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(_:)))
        self.navigationItem.leftBarButtonItem = cancel
    }
}
