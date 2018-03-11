//
//  FifteenViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 04.12.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

class FifteenViewController: UIViewController {
    
    @IBOutlet weak var webView15: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlpath = Bundle.main.path(forResource: "marsvonzuhause", ofType: "pdf");
        let requesturl = URL(string: urlpath!)
        let request = URLRequest(url: requesturl!)
        
        Answers.logContentView(withName: "MarsVonZuhause",
                               contentType: "MarsVonZuhause",
                               contentId: "marsvonzuhause",
                               customAttributes: [:])
        
        webView15.loadRequest(request)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let urlpath = Bundle.main.path(forResource: "marsvonzuhause", ofType: "pdf");
        let requesturl = URL(string: urlpath!)
        let request = URLRequest(url: requesturl!)
        
        Answers.logContentView(withName: "MarsVonZuhause",
                               contentType: "MarsVonZuhause",
                               contentId: "marsvonzuhause",
                               customAttributes: [:])
        
        webView15.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
