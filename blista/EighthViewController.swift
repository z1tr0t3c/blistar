//
//  EighthViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 01.12.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

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
            
           webView8.loadRequest(URLRequest(url: URL(string: "https://katalog.blista.de/allegro")!))
            
        case .cellular:
            
            Answers.logContentView(withName: "Katalog",
                                   contentType: "Katalog",
                                   contentId: "katalog",
                                   customAttributes: [:])
            
            webView8.loadRequest(URLRequest(url: URL(string: "https://katalog.blista.de/allegro")!))
            
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
                webView8.loadRequest(URLRequest(url: URL(string: "https://katalog.blista.de/allegro")!))
            }
            
            
        case .cellular:
            if viewHasLoaded == true {
                return
            } else {
                webView8.loadRequest(URLRequest(url: URL(string: "https://katalog.blista.de/allegro")!))
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
            
            if (request.url!.host == "katalog.blista.de") {
                return true
            } else {
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
                } else {
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
