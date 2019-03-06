//
//  ReposWebViewController.swift
//  AuthGithub
//
//  Created by Vladislav on 06/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit
import WebKit

class ReposWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.frame = self.view.frame

        // Do any additional setup after loading the view.
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
