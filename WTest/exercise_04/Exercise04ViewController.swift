//
//  Exercise04ViewController.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 09/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class Exercise04ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var wvContent: WKWebView!
    
    // check which target is active and load the correct website
    // there is a compiler flag that identifies the target (Other Swift Flags, on build settings)
    // there is 3 targets (WTest, WTestX and WTestY)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url: URL?
        
        #if WTest
        url = URL(string: "https://www.google.com")
        #endif
        
        #if WTestX
        url = URL(string: "https://www.apple.com")
        #endif
        
        #if WTestY
        url = URL(string: "https://www.microsoft.com")
        #endif
        
        if let url = url {
            wvContent.load(URLRequest(url: url))
            wvContent.allowsBackForwardNavigationGestures = true
            wvContent.navigationDelegate = self
            
            SVProgressHUD.show(withStatus: NSLocalizedString("Loading...", comment: ""))
        } else {
            wvContent.load(URLRequest(url: URL(string: "https://www.amazon.com")!))
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }

}
