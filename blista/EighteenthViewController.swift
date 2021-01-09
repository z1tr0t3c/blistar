//
//  EighteenthViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 15.05.18.
//  Copyright © 2018 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

class EighteenthViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView18: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            
            Answers.logContentView(withName: "Ankündigen",
                                   contentType: "Ankündigen",
                                   contentId: "ankündigen",
                                   customAttributes: [:])
            
            webView18.loadRequest(URLRequest(url: URL(string: "https://css.moodle.blista.study/mod/forum/search.php?id=3&words&phrase&notwords&fullwords&timefromrestrict=1&fromday=1&frommonth=1&fromyear=2000&fromhour=0&fromminute=0&hfromday=0&hfrommonth=0&hfromyear=0&hfromhour=0&hfromminute=0&htoday=1&htomonth=1&htoyear=1&htohour=1&htominute=1&forumid&subject&user#maincontent")!))
        case .cellular:
            
            Answers.logContentView(withName: "Ankündigen",
                                   contentType: "Ankündigen",
                                   contentId: "ankündigen",
                                   customAttributes: [:])
            
            webView18.loadRequest(URLRequest(url: URL(string: "https://css.moodle.blista.study/mod/forum/search.php?id=3&words&phrase&notwords&fullwords&timefromrestrict=1&fromday=1&frommonth=1&fromyear=2000&fromhour=0&fromminute=0&hfromday=0&hfrommonth=0&hfromyear=0&hfromhour=0&hfromminute=0&htoday=1&htomonth=1&htoyear=1&htohour=1&htominute=1&forumid&subject&user#maincontent")!))
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
            
            Answers.logContentView(withName: "Ankündigen",
                                   contentType: "Ankündigen",
                                   contentId: "ankündigen",
                                   customAttributes: [:])
            
            webView18.loadRequest(URLRequest(url: URL(string: "https://css.moodle.blista.study/mod/forum/search.php?id=3&words&phrase&notwords&fullwords&timefromrestrict=1&fromday=1&frommonth=1&fromyear=2000&fromhour=0&fromminute=0&hfromday=0&hfrommonth=0&hfromyear=0&hfromhour=0&hfromminute=0&htoday=1&htomonth=1&htoyear=1&htohour=1&htominute=1&forumid&subject&user#maincontent")!))
        case .cellular:
            
            Answers.logContentView(withName: "Ankündigen",
                                   contentType: "Ankündigen",
                                   contentId: "ankündigen",
                                   customAttributes: [:])
            
            webView18.loadRequest(URLRequest(url: URL(string: "https://css.moodle.blista.study/mod/forum/search.php?id=3&words&phrase&notwords&fullwords&timefromrestrict=1&fromday=1&frommonth=1&fromyear=2000&fromhour=0&fromminute=0&hfromday=0&hfrommonth=0&hfromyear=0&hfromhour=0&hfromminute=0&htoday=1&htomonth=1&htoyear=1&htohour=1&htominute=1&forumid&subject&user#maincontent")!))
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
