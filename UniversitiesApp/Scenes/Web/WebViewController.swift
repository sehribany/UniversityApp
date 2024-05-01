//
//  WebViewController.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 26.04.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var websiteURL: String = ""
    var universityName: String = ""
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubViews()
        loadWebsite()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func loadWebsite() {
        if let url = URL(string: websiteURL) {
            print(url)
            webView.load(URLRequest(url: url))
        }
    }
}

// MARK: -UILayout
extension WebViewController{
    private func addSubViews(){
        addWebView()
    }
    
    private func addWebView(){
        view.addSubview(webView)
        webView.edgesToSuperview()
    }
    
    private func configure(){
        navigationItem.title = universityName
        view.backgroundColor = .appWhite
    }
}

extension WebViewController {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        presentAlert(title: "Loading Error", message: "The webpage could not be loaded. Please check the URL and your internet connection.")
    }
    
    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
