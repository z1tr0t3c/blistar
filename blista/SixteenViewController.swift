//
//  SixteenViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 04.12.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics

class SixteenViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView16: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let rightBarButton = UIBarButtonItem(title: "Spenden", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SixteenViewController.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            UserDefaults.standard.register(defaults: ["UserAgent": "blistar/"+version!])
            
            Answers.logContentView(withName: "Über diese App",
                                   contentType: "Über diese App",
                                   contentId: "about",
                                   customAttributes: [:])
            
            webView16.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/blista")!))
        case .cellular:
            UserDefaults.standard.register(defaults: ["UserAgent": "blistar/"+version!])
            
            Answers.logContentView(withName: "Über diese App",
                                   contentType: "Über diese App",
                                   contentId: "about",
                                   customAttributes: [:])
            
            webView16.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/blista")!))
        case .none:
            let urlpath = Bundle.main.path(forResource: "index", ofType: "html");
            let requesturl = URL(string: urlpath!)
            let request = URLRequest(url: requesturl!)
            webView16.loadRequest(request)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .wifi:
            UserDefaults.standard.register(defaults: ["UserAgent": "blistar/"+version!])
            
            Answers.logContentView(withName: "Über diese App",
                                   contentType: "Über diese App",
                                   contentId: "about",
                                   customAttributes: [:])
            
            webView16.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/blista")!))
        case .cellular:
            UserDefaults.standard.register(defaults: ["UserAgent": "blistar/"+version!])
            
            Answers.logContentView(withName: "Über diese App",
                                   contentType: "Über diese App",
                                   contentId: "about",
                                   customAttributes: [:])
            
            webView16.loadRequest(URLRequest(url: URL(string: "https://zitrotec.de/blista")!))
        case .none:
            let urlpath = Bundle.main.path(forResource: "index", ofType: "html");
            let requesturl = URL(string: urlpath!)
            let request = URLRequest(url: requesturl!)
            webView16.loadRequest(request)
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
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        
         let defaults = UserDefaults.standard
         
         let activation_id = defaults.string(forKey: "activation_id")
         let the_key = defaults.string(forKey: "the_key")
         let expire_date = defaults.string(forKey: "expire_date")
         let has_expired = defaults.bool(forKey: "has_expired")
         let name = defaults.string(forKey: "name")
         let active = defaults.bool(forKey: "active")

         if active {
         let UserInfo1 = "Abo: \n" + (name ?? "null")
         let UserInfo2 = "\n Ablaufdatum: \n" + (expire_date ?? "null")
         let UserInfo3 = "\n Aktivierungs-ID: \n" + (activation_id ?? "null")
         let UserInfo = UserInfo1 + UserInfo2 + UserInfo3
         
         let alert2 = UIAlertController(title: "Vielen Dank für deinen Support 💚", message: "Toll das du mithilfst, die blistar-App auch in Zukunft kostenlos anbieten zu können. \n Details: \n" + (UserInfo ), preferredStyle: UIAlertControllerStyle.alert)

         let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
             // Spark!
         })
             
         let action2 = UIAlertAction(title: "Abo verwalten", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
            let url2 = URL(string:"https://zitrotec.de/it-service/mein-konto/view-license-key?key=\(the_key ?? "null")")
             
                let reachability = Reachability()!
                
                switch reachability.connection {
                case .wifi:
                    
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url2!, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url2!)
                    }

                case .cellular:
                    
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url2!, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url2!)
                    }
                    
                case .none:
                    let alert = UIAlertView()
                    alert.title = "Du bist Offline"
                    alert.message = "Bitte stell eine Internetverbindung her, um diesen Inhalt anzuzeigen."
                    alert.addButton(withTitle: "OK")
                    alert.show()
                }
                })

         alert2.addAction(action)
         alert2.addAction(action2)
         self.present(alert2, animated: true, completion: nil)
         
         } else {
         
            let url = URL(string:"https://zitrotec.de/it-service/referenzen/blista/spenden")
            
               let reachability = Reachability()!
               
               switch reachability.connection {
               case .wifi:
                   
                   if #available(iOS 10.0, *) {
                       UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                   } else {
                       UIApplication.shared.openURL(url!)
                   }

               case .cellular:
                   
                   if #available(iOS 10.0, *) {
                       UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                   } else {
                       UIApplication.shared.openURL(url!)
                   }
                   
               case .none:
                   let alert = UIAlertView()
                   alert.title = "Du bist Offline"
                   alert.message = "Bitte stell eine Internetverbindung her, um diesen Inhalt anzuzeigen."
                   alert.addButton(withTitle: "OK")
                   alert.show()
               }
               }
            
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
