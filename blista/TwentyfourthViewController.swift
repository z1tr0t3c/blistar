//
//  TwentyfourthViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 27.06.19.
//  Copyright © 2019 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

private var viewHasLoaded = false

class TwentyfourthViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView24: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            
            Answers.logContentView(withName: "Stundenplan",
                                   contentType: "Stundenplan",
                                   contentId: "stundenplan",
                                   customAttributes: [:])
            
            webView24.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/stundenplan/display.php")!))
        case .cellular:
            
            Answers.logContentView(withName: "Stundenplan",
                                   contentType: "Stundenplan",
                                   contentId: "stundenplan",
                                   customAttributes: [:])
            
            webView24.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/stundenplan/display.php")!))
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
            
            Answers.logContentView(withName: "Stundenplan",
                                   contentType: "Stundenplan",
                                   contentId: "stundenplan",
                                   customAttributes: [:])
            if viewHasLoaded == true {
                return
            } else {
            webView24.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/stundenplan/display.php")!))
             }
                
        case .cellular:
            
            Answers.logContentView(withName: "Stundenplan",
                                   contentType: "Stundenplan",
                                   contentId: "stundenplan",
                                   customAttributes: [:])
                if viewHasLoaded == true {
                    return
                } else {
            webView24.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/stundenplan/display.php")!))
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
