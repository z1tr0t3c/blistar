//
//  SeventhViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 01.12.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

class SeventhViewController: UIViewController, UIWebViewDelegate {
        
    @IBOutlet weak var webView7: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            
            Answers.logContentView(withName: "Termine",
                                   contentType: "Termine",
                                   contentId: "termine",
                                   customAttributes: [:])
            
            webView7.loadRequest(URLRequest(url: URL(string: "https://blista.de/content/termine-0#page-content")!))
        case .cellular:
            
            Answers.logContentView(withName: "Termine",
                                   contentType: "Termine",
                                   contentId: "termine",
                                   customAttributes: [:])
            
            webView7.loadRequest(URLRequest(url: URL(string: "https://blista.de/content/termine-0#page-content")!))
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
            
            Answers.logContentView(withName: "Termine",
                                   contentType: "Termine",
                                   contentId: "termine",
                                   customAttributes: [:])
            
            webView7.loadRequest(URLRequest(url: URL(string: "https://blista.de/content/termine-0#page-content")!))
        case .cellular:
            
            Answers.logContentView(withName: "Termine",
                                   contentType: "Termine",
                                   contentId: "termine",
                                   customAttributes: [:])
            
            webView7.loadRequest(URLRequest(url: URL(string: "https://blista.de/content/termine-0#page-content")!))
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
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        activity.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

