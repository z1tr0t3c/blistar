//
//  TwentyfifthViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 23.02.20.
//  Copyright © 2020 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

class TwentyfifthViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            
            Answers.logContentView(withName: "blistaMeet",
                                   contentType: "blistaMeet",
                                   contentId: "blistameet",
                                   customAttributes: [:])
            
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            
    if let url = URL(string: "https://zitrotec.de/blista/meet.html") {
        if #available(iOS 10.0, *) {
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
           UIApplication.shared.openURL(url)
        }
    }
            
        case .cellular:
            
            Answers.logContentView(withName: "blistaMeet",
                                   contentType: "blistaMeet",
                                   contentId: "blistameet",
                                   customAttributes: [:])
            
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            
        if let url = URL(string: "https://zitrotec.de/blista/meet.html") {
            if #available(iOS 10.0, *) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
               UIApplication.shared.openURL(url)
            }
        }
        
        case .none:

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
            
            Answers.logContentView(withName: "blistaMeet",
                                   contentType: "blistaMeet",
                                   contentId: "blistameet",
                                   customAttributes: [:])
            
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            
        if let url = URL(string: "https://zitrotec.de/blista/meet.html") {
            if #available(iOS 10.0, *) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
               UIApplication.shared.openURL(url)
            }
        }
            
        case .cellular:
            
            Answers.logContentView(withName: "blistaMeet",
                                   contentType: "blistaMeet",
                                   contentId: "blistameet",
                                   customAttributes: [:])
            
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            
        if let url = URL(string: "https://zitrotec.de/blista/meet.html") {
            if #available(iOS 10.0, *) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
               UIApplication.shared.openURL(url)
            }
        }
       
        case .none:

            navigationController?.popViewController(animated: true)
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
