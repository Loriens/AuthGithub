//
//  ReposWebViewController.swift
//  AuthGithub
//
//  Created by Vladislav on 06/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit
import WebKit

class ReposWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    // Ссылка на репозиторий в виде строки
    var repoHtml: String?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let repoURL = URL(string: repoHtml!)!
        let request = URLRequest(url: repoURL)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
