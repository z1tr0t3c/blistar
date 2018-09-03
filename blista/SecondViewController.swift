//
//  SecondViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 30.11.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

class SecondViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView2: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func indexChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            loadVPlan ()
        case 1:
            loadVPlanVorschau ()
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        segmentedControl.sendActions(for: UIControlEvents.valueChanged)
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        segmentedControl.sendActions(for: UIControlEvents.valueChanged)
    }
    
    func loadVPlan () {
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            
            Answers.logContentView(withName: "VPlan Lehrer",
                                   contentType: "VPlan Lehrer",
                                   contentId: "vplan2",
                                   customAttributes: [:])
            
            webView2.loadRequest(URLRequest(url: URL(string: "https://edu.blista.de/moodle/mod/resource/view.php?id=41#maincontent")!))
            
        case .cellular:
            
            Answers.logContentView(withName: "VPlan Lehrer",
                                   contentType: "VPlan Lehrer",
                                   contentId: "vplan2",
                                   customAttributes: [:])
            
            webView2.loadRequest(URLRequest(url: URL(string: "https://edu.blista.de/moodle/mod/resource/view.php?id=41#maincontent")!))
            
        case .none:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            activity.stopAnimating()
            let alert = UIAlertView()
            alert.title = "Du bist Offline"
            alert.message = "Bitte stell eine Internetverbindung her, um diesen Inhalt anzuzeigen."
            alert.addButton(withTitle: "OK")
            alert.show()
        }
    }
    
    func loadVPlanVorschau () {
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            
            Answers.logContentView(withName: "VPlan Lehrer Vorschau",
                                   contentType: "VPlan Lehrer Vorschau",
                                   contentId: "vplan2vorschau",
                                   customAttributes: [:])
            
            webView2.loadRequest(URLRequest(url: URL(string: "https://edu.blista.de/moodle/mod/resource/view.php?id=45#maincontent")!))
            
        case .cellular:
            
            Answers.logContentView(withName: "VPlan Lehrer Vorschau",
                                   contentType: "VPlan Lehrer Vorschau",
                                   contentId: "vplan2vorschau",
                                   customAttributes: [:])
            
            webView2.loadRequest(URLRequest(url: URL(string: "https://edu.blista.de/moodle/mod/resource/view.php?id=45#maincontent")!))
            
        case .none:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            activity.stopAnimating()
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
