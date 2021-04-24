//
//  EighthViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 01.12.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics
import SafariServices

private var viewHasLoaded = false

class EighthViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView8: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.

        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            
            Answers.logContentView(withName: "Katalog",
                                   contentType: "Katalog",
                                   contentId: "katalog",
                                   customAttributes: [:])
            
           webView8.loadRequest(URLRequest(url: URL(string: "https://katalog.blista.de/")!))
            
        case .cellular:
            
            Answers.logContentView(withName: "Katalog",
                                   contentType: "Katalog",
                                   contentId: "katalog",
                                   customAttributes: [:])
            
            webView8.loadRequest(URLRequest(url: URL(string: "https://katalog.blista.de/")!))
            
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            
            if viewHasLoaded == true {
                return
            } else {
                webView8.loadRequest(URLRequest(url: URL(string: "https://katalog.blista.de/")!))
            }
            
            
        case .cellular:
            if viewHasLoaded == true {
                return
            } else {
                webView8.loadRequest(URLRequest(url: URL(string: "https://katalog.blista.de/")!))
            }
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
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.linkClicked {
            
            if (request.url!.scheme == "mailto") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(request.url!)
                    }
                return false
            }
                                   
            if (request.url!.scheme == "tel") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(request.url!)
                }
                return false
            }
            
            if (request.url!.pathExtension == "zip") || (request.url!.host == "blibu-katalog.blista.de") {

                let userDefaults = UserDefaults.standard
                let wifisetting = userDefaults.bool(forKey: "wifionly")
                if wifisetting == true
                {
                    
                    let reachability = Reachability()!
                    
                    if reachability.connection == .cellular {
                        
                        if self.webView8.isLoading {
                        self.webView8.stopLoading()
                        }
                        
                        let wifialert =  UIAlertController(title: "Keine WLAN-Verbindung", message: "Du hast in den Einstellungen festgelegt, dass du Downloads nur über WLAN zulässt. Um dies zu ändern gehe in die Einstellungen.", preferredStyle: .alert)
                        
                        
                        let cancelAction = UIAlertAction(title: "OK", style: .cancel) {action -> Void in

                        }
                        wifialert.addAction(cancelAction)
                        
                        let okAction = UIAlertAction(title: "Einstellungen", style: .default) {action -> Void in
                            
                            let url = URL(string:UIApplicationOpenSettingsURLString)
                            
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(url!)
                            }
                        }
                        wifialert.addAction(okAction)
                        
                        self.present(wifialert, animated: true, completion: nil)
                            
                        return true
                        
                    }
                }
                
                if #available(iOS 9.0, *) {
                    UIApplication.shared.isIdleTimerDisabled = true
                    let vc = SFSafariViewController(url: request.url!)
                        let blistaColor = UIColor(red: 0, green: 0.651, blue: 0.1137, alpha: 1)
                        if #available(iOS 10.0, *) {
                            vc.preferredControlTintColor = blistaColor
                        } else {
                            vc.view.tintColor = blistaColor
                        }
                            present(vc, animated: true)
                    } else {
                    UIApplication.shared.isIdleTimerDisabled = false
                        UIApplication.shared.openURL(request.url!)
                    }
                
                return false
            }
        }
        return true
    }
            
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
