//
//  TwentyfourthViewController.swift
//  
//
//  Created by Falk Rismansanj on 03.09.18.
//

import UIKit
import Crashlytics

class TwentyfourthViewController: UIViewController {
    
    @IBOutlet weak var webView24: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlpath = Bundle.main.path(forResource: "sommerfestprogramm", ofType: "pdf");
        let requesturl = URL(string: urlpath!)
        let request = URLRequest(url: requesturl!)
        
        Answers.logContentView(withName: "Sommerfestprogramm",
                               contentType: "Sommerfestprogramm",
                               contentId: "sommerfestprogramm",
                               customAttributes: [:])
        
        webView24.loadRequest(request)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let urlpath = Bundle.main.path(forResource: "sommerfestprogramm", ofType: "pdf");
        let requesturl = URL(string: urlpath!)
        let request = URLRequest(url: requesturl!)
        
        Answers.logContentView(withName: "Sommerfestprogramm",
                               contentType: "Sommerfestprogramm",
                               contentId: "sommerfestprogramm",
                               customAttributes: [:])
        
        webView24.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
