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
    
    // Ссылка на репозиторий в виде строки
    var repoHtml: String?
    var webView: WKWebView!
    
    override func loadView() {
        let source = "document.body.style.background = \"#808080\";"
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = userContentController
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

}
