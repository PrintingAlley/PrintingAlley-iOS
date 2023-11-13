//
//  WebViewController.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import SnapKit
import Then
import UIKit
import WebKit
import UtilityModule
import DesignSystem

class WebViewController: UIViewController {
    
    lazy var  preferences: WKPreferences = WKPreferences().then {
        $0.javaScriptCanOpenWindowsAutomatically = true
        /** 자동으로 javaScript를 통해 새 창 열기 설정 */
    }
    
    lazy var  contentController: WKUserContentController = WKUserContentController()
    
    lazy var configuration = WKWebViewConfiguration().then{
        /** preference, contentController 설정 */
        $0.preferences = preferences
        $0.userContentController = contentController
    }
    
    let pagePreferences: WKWebpagePreferences = WKWebpagePreferences().then {
        $0.allowsContentJavaScript = true
    }
    
    
    lazy var backgroundView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    lazy var naviTitleView: UIView = UIView()
    
    lazy var titleLabel: AlleyLabel = AlleyLabel()
    
    lazy var backButton: UIButton = UIButton().then {
        
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(back), for: .touchUpInside)
    }

    lazy var webView: WKWebView! = WKWebView(frame: .zero, configuration: configuration).then {
        $0.backgroundColor = .white
    }
    
    var naviTitle: String!
    var url: String!
    
    init(naviTitle: String!, url: String!) {
        super.init(nibName: nil, bundle: nil)
        self.naviTitle = naviTitle
        self.url = url
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        makeConstraints()
       
        titleLabel.setTitle(title: naviTitle, textColor: .sub(.black), font: .body1, alignment: .center)
        setWebViewURLRequest()
        configureCommonUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSwipeBack()
    }
    
}

extension WebViewController {
    func addSubviews() {
        self.view.addSubviews(naviTitleView,backgroundView)
        
        naviTitleView.addSubviews(titleLabel,backButton)
        
        backgroundView.addSubview(webView)
    }
    
    func makeConstraints() {
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(naviTitleView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    
        
        naviTitleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(12)
            $0.height.equalTo(32)
            $0.left.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func setWebViewURLRequest() {
        
        var componets = URLComponents(string: self.url)!
        
        let request = URLRequest(url: componets.url!)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.load(request) // 이동
        
        
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WebViewController: WKUIDelegate {

}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        
        decisionHandler(.allow)
    }
}

extension WebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        // add 함수를 통해 등록한 메시지를 WKScriptMessageHandler 클래스를 통해 javaScript(즉, 웹 페이지)로 부터 메시지를 받아올 수 있다.
        
        DEBUG_LOG(message.name)
    }

}


