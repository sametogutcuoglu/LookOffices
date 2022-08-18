//
//  OfficeWebSiteViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 17.08.2022.
//

import UIKit
import WebKit

protocol OfficeWebSiteDisplayLogic: AnyObject {
    
}

final class OfficeWebSiteViewController: UIViewController {
    
    var interactor: OfficeWebSiteBusinessLogic?
    var router: (OfficeWebSiteRoutingLogic & OfficeWebSiteDataPassing)?
    
    var progressView : UIProgressView!
    let backButton = UIButton()
    let forwordButton = UIButton()
    
    var websites = [ "https://www.mobven.com/","https://www.mobven.com/solutions-software-development/"]
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self

        guard let url = URL(string: "https://www.mobven.com") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
        navigationController?.isToolbarHidden = false
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
       
        backButton.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 5, height: 5))
        backButton.backgroundImage(for: .normal)
        backButton.setImage(UIImage.toolbarBackButton, for: .normal)
        backButton.addTarget(self, action: #selector(clickToolBarBackButton), for: .touchUpInside)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        
        forwordButton.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 5, height: 5))
        forwordButton.backgroundImage(for: .normal)
        forwordButton.setImage(UIImage.toolbarForwardButton, for: .normal)
        forwordButton.addTarget(self, action: #selector(clickToolBarForWordButton), for: .touchUpInside)
        let forwordButtonItem = UIBarButtonItem(customView: forwordButton)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressViewItem = UIBarButtonItem(customView: progressView)
        let loadAnimate = UIBarButtonItem(customView: indicator)
        
        toolbarItems = [backButtonItem,forwordButtonItem,space,progressViewItem,space,loadAnimate,refresh]
        // webview sayfa yüklenmesini dinliyorum ki ileri git ya da geri gel butonlarımın opacity ayarlayabileyim
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new ,context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new ,context: nil)
    }
    
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
        else if keyPath == "loading" {
            let isGetBack = webView.canGoBack // geri dönülecek bir sayfa varsa true
            let getForward = webView.canGoForward // ileri gidilecek bir sayfa varsa true
            if isGetBack {
                backButton.layer.opacity = 1
            }
            else {
                backButton.layer.opacity = 0.2
            }
            if getForward {
                forwordButton.layer.opacity = 1
            }
            else {
                forwordButton.layer.opacity = 0.2
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.isToolbarHidden = true
    }
    
    @objc func clickToolBarBackButton() {
        webView.goBack()
    }
    
    @objc func clickToolBarForWordButton() {
        webView.goForward()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficeWebSiteInteractor()
        let presenter = OfficeWebSitePresenter()
        let router = OfficeWebSiteRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension OfficeWebSiteViewController: OfficeWebSiteDisplayLogic {
    
}

extension OfficeWebSiteViewController :  WKNavigationDelegate {
    // MARK: Webview Staring,Stop Animating
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showIndicate(show: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showIndicate(show: false)
    }
    
    func showIndicate(show : Bool) {
        show ? indicator.startAnimating() : indicator.stopAnimating()
    }
    // MARK: tıklanılan host tanımlı olan hostlar içinde mi kontrol edip ona göre yönlendirme yapıyoruz
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.absoluteString  {
            let don = websites.filter({$0.contains(host)})
            if don.count > 0 {
                decisionHandler(.allow)
                return
            }
                else {
                decisionHandler(.cancel)
                }
        }
    }
    
}
