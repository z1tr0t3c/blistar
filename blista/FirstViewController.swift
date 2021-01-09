//
//  FirstViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 30.11.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

class FirstViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView1: UIWebView!
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
            
            Answers.logContentView(withName: "VPlan Schüler",
                                   contentType: "VPlan Schüler",
                                   contentId: "vplan1",
                                   customAttributes: [:])
            
            webView1.loadRequest(URLRequest(url: URL(string: "https://css.moodle.blista.study/mod/resource/view.php?id=39#maincontent")!))
            
        case .cellular:
            
            Answers.logContentView(withName: "VPlan Schüler",
                                   contentType: "VPlan Schüler",
                                   contentId: "vplan1",
                                   customAttributes: [:])
            
            webView1.loadRequest(URLRequest(url: URL(string: "https://css.moodle.blista.study/mod/resource/view.php?id=39#maincontent")!))
            
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
            
            Answers.logContentView(withName: "VPlan Schüler Vorschau",
                                   contentType: "VPlan Schüler Vorschau",
                                   contentId: "vplan1vorschau",
                                   customAttributes: [:])
            
            webView1.loadRequest(URLRequest(url: URL(string: "https://css.moodle.blista.study/mod/resource/view.php?id=43#maincontent")!))
            
        case .cellular:
            
            Answers.logContentView(withName: "VPlan Schüler Vorschau",
                                   contentType: "VPlan Schüler Vorschau",
                                   contentId: "vplan1vorschau",
                                   customAttributes: [:])
            
            webView1.loadRequest(URLRequest(url: URL(string: "https://css.moodle.blista.study/mod/resource/view.php?id=43#maincontent")!))
            
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
