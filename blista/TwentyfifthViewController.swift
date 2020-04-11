//
//  TwentyfifthViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 23.02.20.
//  Copyright © 2020 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics
import AVFoundation
import QRCodeReader
import AudioToolbox

private var viewHasLoaded = false

class TwentyfifthViewController: UIViewController, UIWebViewDelegate, QRCodeReaderViewControllerDelegate {
    
    @IBOutlet weak var webView25: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
                
        let userDefaults = UserDefaults.standard
        let mensasetting = userDefaults.bool(forKey: "mensa")
        if mensasetting == true
        {
            let rightBarButton = UIBarButtonItem(title: "Scannen", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SixteenViewController.myRightSideBarButtonItemTapped(_:)))
                   self.navigationItem.rightBarButtonItem = rightBarButton
                   
            let urlpath = Bundle.main.path(forResource: "mensa", ofType: "pdf");
            let requesturl = URL(string: urlpath!)
            let request = URLRequest(url: requesturl!)
            webView25.loadRequest(request)
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            activity.stopAnimating()
           let readerVC: QRCodeReaderViewController = {
           let builder = QRCodeReaderViewControllerBuilder {
                    $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = true
            $0.showOverlayView        = true
                }
                return QRCodeReaderViewController(builder: builder)
                }()

            readerVC.modalPresentationStyle = .formSheet

            let reachability = Reachability()!
            
            switch reachability.connection {
            case .wifi:
                present(readerVC, animated: true, completion: nil)
                readerVC.delegate = self
                readerVC.completionBlock = { (result: QRCodeReaderResult?) in
                  if let result = result {
                  print("Completion with result: \(result.value)")
                    if #available(iOS 9.0, *) {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
                    } else {
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    }
                      let urlString = result.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                      let url = URL(string: urlString!)
                      let request = URLRequest(url: url!)
                      if (request.url!.host == "zitrotec.de") {
                      self.webView25.loadRequest(request)
                      } else {
                      }
                    }
                }
            case .cellular:
                present(readerVC, animated: true, completion: nil)
                readerVC.delegate = self
                readerVC.completionBlock = { (result: QRCodeReaderResult?) in
                  if let result = result {
                  print("Completion with result: \(result.value)")
                    if #available(iOS 9.0, *) {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
                    } else {
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    }
                    let urlString = result.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    let url = URL(string: urlString!)
                    let request = URLRequest(url: url!)
                    if (request.url!.host == "zitrotec.de") {
                    self.webView25.loadRequest(request)
                    } else {
                    }
                    }
                }
            case .none:
                dismiss(animated: true, completion: nil)
                let alert = UIAlertView()
                alert.title = "Du bist Offline"
                alert.message = "Bitte stell eine Internetverbindung her, um diesen Inhalt anzuzeigen."
                alert.addButton(withTitle: "OK")
                alert.show()
            }
        }
        else {
            let reachability = Reachability()!
            
            switch reachability.connection {
            case .wifi:
                
                Answers.logContentView(withName: "Essen",
                                       contentType: "Essen",
                                       contentId: "essen",
                                       customAttributes: [:])
                
                webView25.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/it-service/blistar-essen-bestellen")!))
            case .cellular:
                
                Answers.logContentView(withName: "Essen",
                                       contentType: "Essen",
                                       contentId: "essen",
                                       customAttributes: [:])
                
                webView25.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/it-service/blistar-essen-bestellen")!))
            case .none:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                activity.stopAnimating()
                navigationController?.popViewController(animated: true)
                dismiss(animated: true, completion: nil)
                let alert = UIAlertView()
                alert.title = "Du bist Offline"
                alert.message = "Bitte stell eine Internetverbindung her, um diesen Inhalt anzuzeigen."
                alert.addButton(withTitle: "OK")
                alert.show()
    }
            }
        }

    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userDefaults = UserDefaults.standard
        let mensasetting = userDefaults.bool(forKey: "mensa")
        if mensasetting == true
            {
               UIApplication.shared.isNetworkActivityIndicatorVisible = false
               activity.stopAnimating()
               let reachability = Reachability()!
                
                switch reachability.connection {
                case .wifi:
                let urlpath = Bundle.main.path(forResource: "mensa", ofType: "pdf");
                let requesturl = URL(string: urlpath!)
                let request = URLRequest(url: requesturl!)
               webView25.loadRequest(request)
                case .cellular:
                    let urlpath = Bundle.main.path(forResource: "mensa", ofType: "pdf");
                    let requesturl = URL(string: urlpath!)
                    let request = URLRequest(url: requesturl!)
                    webView25.loadRequest(request)
                case .none:
                 let urlpath = Bundle.main.path(forResource: "mensa", ofType: "pdf");
                 let requesturl = URL(string: urlpath!)
                 let request = URLRequest(url: requesturl!)
                webView25.loadRequest(request)
                }
            }
            else {
                let reachability = Reachability()!
                
                switch reachability.connection {
                case .wifi:
                    
                    Answers.logContentView(withName: "Essen",
                                           contentType: "Essen",
                                           contentId: "essen",
                                           customAttributes: [:])
                    
                    webView25.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/it-service/blistar-essen-bestellen")!))
                case .cellular:
                    
                    Answers.logContentView(withName: "Essen",
                                           contentType: "Essen",
                                           contentId: "essen",
                                           customAttributes: [:])
                    
                    webView25.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/it-service/blistar-essen-bestellen")!))
                case .none:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    activity.stopAnimating()
                    navigationController?.popViewController(animated: true)
                    dismiss(animated: true, completion: nil)
                    let alert = UIAlertView()
                    alert.title = "Du bist Offline"
                    alert.message = "Bitte stell eine Internetverbindung her, um diesen Inhalt anzuzeigen."
                    alert.addButton(withTitle: "OK")
                    alert.show()
        }
    }
        }
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        activity.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        activity.stopAnimating()
        viewHasLoaded = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        activity.stopAnimating()
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        let readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
                 $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
         $0.showTorchButton        = false
         $0.showSwitchCameraButton = false
         $0.showCancelButton       = true
         $0.showOverlayView        = true
             }
             return QRCodeReaderViewController(builder: builder)
             }()

        readerVC.modalPresentationStyle = .formSheet
        
        let reachability = Reachability()!
        
             switch reachability.connection {
             case .wifi:
                 present(readerVC, animated: true, completion: nil)
                 readerVC.delegate = self
                 readerVC.completionBlock = { (result: QRCodeReaderResult?) in
                   if let result = result {
                   print("Completion with result: \(result.value)")
                    if #available(iOS 9.0, *) {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
                    } else {
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    }
                       let urlString = result.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                       let url = URL(string: urlString!)
                       let request = URLRequest(url: url!)
                       if (request.url!.host == "zitrotec.de") {
                       self.webView25.loadRequest(request)
                       } else {
                       }
                     }
                 }
             case .cellular:
                 present(readerVC, animated: true, completion: nil)
                 readerVC.delegate = self
                 readerVC.completionBlock = { (result: QRCodeReaderResult?) in
                   if let result = result {
                   print("Completion with result: \(result.value)")
                    if #available(iOS 9.0, *) {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
                    } else {
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    }
                       let urlString = result.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                       let url = URL(string: urlString!)
                       let request = URLRequest(url: url!)
                       if (request.url!.host == "zitrotec.de") {
                       self.webView25.loadRequest(request)
                       } else {
                       }
                     }
                 }
             case .none:
                dismiss(animated: true, completion: nil)
                 let alert = UIAlertView()
                 alert.title = "Du bist Offline"
                 alert.message = "Bitte stell eine Internetverbindung her, um diesen Inhalt anzuzeigen."
                 alert.addButton(withTitle: "OK")
                 alert.show()
             }
         }
    
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
}
