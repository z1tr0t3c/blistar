//
//  TwentythirdViewController.swift
//  
//
//  Created by Falk Rismansanj on 03.09.18.
//

import UIKit
import Crashlytics

class TwentythirdViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView23: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            
            Answers.logContentView(withName: "AGs",
                                   contentType: "AGs",
                                   contentId: "ags",
                                   customAttributes: [:])
            
            webView23.loadRequest(URLRequest(url: URL(string: "https://www.blista.de/sport-und-freizeit-angebote#page-content")!))
        case .cellular:
            
            Answers.logContentView(withName: "AGs",
                                   contentType: "AGs",
                                   contentId: "ags",
                                   customAttributes: [:])
            
            webView23.loadRequest(URLRequest(url: URL(string: "https://www.blista.de/sport-und-freizeit-angebote#page-content")!))
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
            
            Answers.logContentView(withName: "AGs",
                                   contentType: "AGs",
                                   contentId: "ags",
                                   customAttributes: [:])
            
            webView23.loadRequest(URLRequest(url: URL(string: "https://www.blista.de/sport-und-freizeit-angebote#page-content")!))
        case .cellular:
            
            Answers.logContentView(withName: "AGs",
                                   contentType: "AGs",
                                   contentId: "ags",
                                   customAttributes: [:])
            
            webView23.loadRequest(URLRequest(url: URL(string: "https://www.blista.de/sport-und-freizeit-angebote#page-content")!))
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
