//
//  TwentyonethViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 09.08.18.
//  Copyright © 2018 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics
import SafariServices

class TwentyonethViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var webView21: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let rightBarButton = UIBarButtonItem(title: "EDU öffnen", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SixteenViewController.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
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
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        if #available(iOS 9.0, *) {
            if let url = URL(string: "https://edu.blista.de/webfolders") {
                let vc = SFSafariViewController(url: url)
                let blistaColor = UIColor(red: 0, green: 0.651, blue: 0.1137, alpha: 1)
                if #available(iOS 10.0, *) {
                    vc.preferredControlTintColor = blistaColor
                } else {
                    vc.view.tintColor = blistaColor
                }
                    present(vc, animated: true)
            } else {
                let url = URL(string: "https://edu.blista.de/webfolders")
                UIApplication.shared.openURL(url!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
