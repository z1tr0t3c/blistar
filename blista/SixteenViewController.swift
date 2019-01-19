//
//  SixteenViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 04.12.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

class SixteenViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView16: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let rightBarButton = UIBarButtonItem(title: "Spenden", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SixteenViewController.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            UserDefaults.standard.register(defaults: ["UserAgent": "blistar/"+version!])
            
            Answers.logContentView(withName: "Über diese App",
                                   contentType: "Über diese App",
                                   contentId: "about",
                                   customAttributes: [:])
            
            webView16.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/blista")!))
        case .cellular:
            UserDefaults.standard.register(defaults: ["UserAgent": "blistar/"+version!])
            
            Answers.logContentView(withName: "Über diese App",
                                   contentType: "Über diese App",
                                   contentId: "about",
                                   customAttributes: [:])
            
            webView16.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/blista")!))
        case .none:
            let urlpath = Bundle.main.path(forResource: "index", ofType: "html");
            let requesturl = URL(string: urlpath!)
            let request = URLRequest(url: requesturl!)
            webView16.loadRequest(request)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            UserDefaults.standard.register(defaults: ["UserAgent": "blistar/"+version!])
            
            Answers.logContentView(withName: "Über diese App",
                                   contentType: "Über diese App",
                                   contentId: "about",
                                   customAttributes: [:])
            
            webView16.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/blista")!))
        case .cellular:
            UserDefaults.standard.register(defaults: ["UserAgent": "blistar/"+version!])
            
            Answers.logContentView(withName: "Über diese App",
                                   contentType: "Über diese App",
                                   contentId: "about",
                                   customAttributes: [:])
            
            webView16.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/blista")!))
        case .none:
            let urlpath = Bundle.main.path(forResource: "index", ofType: "html");
            let requesturl = URL(string: urlpath!)
            let request = URLRequest(url: requesturl!)
            webView16.loadRequest(request)
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
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        activity.stopAnimating()
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
            let url = URL(string:"https://zitrotec.de/it-service/referenzen/blista/spenden")
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url!)
            }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
