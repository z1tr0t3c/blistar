//
//  TwentyonethViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 09.08.18.
//  Copyright © 2018 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

class TwentyonethViewController: UIViewController {
    
    @IBOutlet weak var webView21: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlpath = Bundle.main.path(forResource: "intranet", ofType: "pdf");
        let requesturl = URL(string: urlpath!)
        let request = URLRequest(url: requesturl!)
        
        Answers.logContentView(withName: "IntraNet-Anleitung",
                               contentType: "IntraNetAnleitung",
                               contentId: "intranet-anleitung",
                               customAttributes: [:])
        
        webView21.loadRequest(request)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let urlpath = Bundle.main.path(forResource: "intranet", ofType: "pdf");
        let requesturl = URL(string: urlpath!)
        let request = URLRequest(url: requesturl!)
        
        Answers.logContentView(withName: "IntraNet-Anleitung",
                               contentType: "IntraNet-Anleitung",
                               contentId: "intranet-anleitung",
                               customAttributes: [:])
        
        webView21.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
