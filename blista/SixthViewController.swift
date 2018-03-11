//
//  SixthViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 01.12.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

class SixthViewController: UIViewController {
    
    @IBOutlet weak var webView6: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlpath = Bundle.main.path(forResource: "opening", ofType: "html");
        let requesturl = URL(string: urlpath!)
        let request = URLRequest(url: requesturl!)
        
        Answers.logContentView(withName: "Öffnungszeiten",
                               contentType: "Öffnungszeiten",
                               contentId: "opening",
                               customAttributes: [:])
        
        webView6.loadRequest(request)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let urlpath = Bundle.main.path(forResource: "opening", ofType: "html");
        let requesturl = URL(string: urlpath!)
        let request = URLRequest(url: requesturl!)
        
        Answers.logContentView(withName: "Öffnungszeiten",
                               contentType: "Öffnungszeiten",
                               contentId: "opening",
                               customAttributes: [:])
        
        webView6.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
