//
//  FirstViewController.swift
//  blista
//
//  Created by Falk Rismansanj on 30.11.17.
//  Copyright © 2017 Falk Rismansanj. All rights reserved.
//

import UIKit
import Crashlytics
import SwiftyJSON

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

    func activateMe() {
        
        let alert = UIAlertController(title: "Bitte denk über eine Spende nach", message: "Die Entwicklung der blistar-App kostet viel Zeit und Geld. Spende für die blistar-App und sichere die Weiterentwicklung der App oder warte 60 Sekunden.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Spenden", style: .default, handler: { action in
            let url = URL(string:"https://zitrotec.de/it-service/referenzen/blista/blistar-app-support-plan")
            
               let reachability = Reachability()!
               
               switch reachability.connection {
               case .wifi:
                   
                   if #available(iOS 10.0, *) {
                       UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                   } else {
                       UIApplication.shared.openURL(url!)
                   }
                self.present(alert, animated: true)

               case .cellular:
                   
                   if #available(iOS 10.0, *) {
                       UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                   } else {
                       UIApplication.shared.openURL(url!)
                   }
                self.present(alert, animated: true)
                   
               case .none:
                   let alert3 = UIAlertView()
                   alert3.title = "Du bist Offline"
                   alert3.message = "Bitte stell eine Internetverbindung her, um diesen Inhalt anzuzeigen."
                   alert3.addButton(withTitle: "OK")
                   alert3.show()
               self.present(alert, animated: true)
               }
        }))
        
        alert.addAction(UIAlertAction(title: "Spendenschlüssel eingeben", style: .default, handler: { action in
            
            let alert2 = UIAlertController(title: "Spendenschlüssel", message: nil, preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: { action in

                self.present(alert, animated: true)
                
            }))
            alert2.addTextField(configurationHandler: { textField in
                textField.placeholder = "Gib deinen Spendenschlüssel ein"
            })

            alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

                let license = alert2.textFields![0]

                if license.text != "" {
                let licenseString = license.text!
                print(licenseString)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true

                    guard let url = URL(string: "https://zitrotec.de/it-service/wp-admin/admin-ajax.php?action=license_key_activate&store_code=F3Up0N7tI87JWEp&sku=blistar-app-subscription-m&license_key=\(licenseString)") else {return}
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let dataResponse = data,
                              error == nil else {
                              print(error?.localizedDescription ?? "Response Error")
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false

                                DispatchQueue.main.async {
                                    let alert5 = UIAlertController(title: "Fehler: " + (error?.localizedDescription ?? "Response Error"), message: "Hilfe zu diesem Fehler findest du auf der Spendenseite.", preferredStyle: UIAlertControllerStyle.alert)

                                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
                                        self.present(alert, animated: true)
                                    })

                                    alert5.addAction(action)
                                    self.present(alert5, animated: true, completion: nil)
                                    
                                }
                                
                              return }
                        let json = try? JSON(data: dataResponse)
                        let status = json?["status"].stringValue
                        print(status ?? "null")
                        let error = json?["errors"]["license_key"][0].stringValue
                        print(error ?? "null")
                        
                        if (status != "200") {

                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            
                            DispatchQueue.main.async {
                                let alert4 = UIAlertController(title: "Fehler: " + (error ?? "null"), message: "Hilfe zu diesem Fehler findest du auf der Spendenseite.", preferredStyle: UIAlertControllerStyle.alert)

                                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
                                    self.present(alert, animated: true)
                                })

                                alert4.addAction(action)
                                self.present(alert4, animated: true, completion: nil)
                                
                            }
                            
                        }
                        
                        else {
                            
                            let message = json?["message"].stringValue
                            
                            let activation_id = json?["data"]["activation_id"].stringValue
                            
                            let expire_date = json?["data"]["expire_date"].stringValue

                            let the_key = json?["data"]["the_key"].stringValue

                            let url = json?["data"]["url"].stringValue

                            let has_expired = json?["data"]["has_expired"].stringValue

                            let status = json?["data"]["status"].stringValue

                            let ctoken = json?["data"]["ctoken"].stringValue
                            
                            let name = json?["data"]["name"].stringValue
                            
                            print("Message:")
                            print(message ?? "null");
                            print("activation_id:")
                            print(activation_id ?? "null");
                            print("expire_date:")
                            print(expire_date ?? "null");
                            print("the_key:")
                            print(the_key ?? "null");
                            print("url:")
                            print(url ?? "null");
                            print("has_expired:")
                            print(has_expired ?? "null");
                            print("status:")
                            print(status ?? "null");
                            print("ctoken:")
                            print(ctoken ?? "null");
                            print("name:")
                            print(name ?? "null");
                            
                            let defaults = UserDefaults.standard

                            defaults.set(activation_id, forKey: "activation_id")
                            defaults.set(expire_date, forKey: "expire_date")
                            defaults.set(the_key, forKey: "the_key")
                            defaults.set(url, forKey: "url")
                            defaults.set(status, forKey: "status")
                            defaults.set(has_expired, forKey: "has_expired")
                            defaults.set(ctoken, forKey: "ctoken")
                            defaults.set(name, forKey: "name")
                            defaults.set(true, forKey: "active")

                            let UserInfo1 = "Abo: \n" + (name ?? "null")
                            let UserInfo2 = "\n Ablaufdatum: \n" + (expire_date ?? "null")
                            let UserInfo3 = "\n Aktivierungs-ID: \n" + (activation_id ?? "null")
                            let UserInfo = UserInfo1 + UserInfo2 + UserInfo3
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false

                            
                            DispatchQueue.main.async {
                                let alert7 = UIAlertController(title: "Erfolg: " + (message ?? "null"), message: "Vielen Dank für deine Unterstützung, die 60 Sek. Wartezeit entfällt nun. \n Details: \n" + (UserInfo ), preferredStyle: UIAlertControllerStyle.alert)

                                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
                                    // Spark!
                                })

                                alert7.addAction(action)
                                self.present(alert7, animated: true, completion: nil)
                                
                            }
                            
                        }
                            
                    }
                    task.resume()
                    
                    
                } else {
                                                            
                    self.present(alert2, animated: true)
                    
                }
                
            }))
            
            self.present(alert2, animated: true)
            
        }))

        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view, typically from a nib.
        
        let defaults = UserDefaults.standard
        
        let activation_id = defaults.string(forKey: "activation_id")
        let the_key = defaults.string(forKey: "the_key")
        let url = defaults.string(forKey: "url")
        let status = defaults.string(forKey: "status")
        let has_expired = defaults.bool(forKey: "has_expired")
        let ctoken = defaults.string(forKey: "ctoken")
        let name = defaults.string(forKey: "name")
        let active = defaults.bool(forKey: "active")

        
        let launchedBefore = defaults.bool(forKey: "launchedBefore")
        if launchedBefore
        {
            print("Not first launch.")
                if !active {
                activateMe()
                DispatchQueue.main.asyncAfter(deadline: .now() + 60.0) {
                 self.dismiss(animated: true, completion: nil)
                }
            }
        }
        else
        {
            print("First launch")
            defaults.set(true, forKey: "launchedBefore")
        }
        
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
