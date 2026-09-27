import UIKit
import WebKit

final class ViewController: UIViewController, WKNavigationDelegate {
    private let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    private let activity = UIActivityIndicatorView(style: .medium)
    private let url = URL(string: "https://whatsapp-sal-gvqunbuq.manus.space")!

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red: 0.984, green: 0.984, blue: 0.980, alpha: 1)

        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(webView)

        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = UIColor(red: 0.059, green: 0.463, blue: 0.431, alpha: 1)
        view.addSubview(activity)

        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
        showError()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
        showError()
    }

    private func showError() {
        let alert = UIAlertController(
            title: "No se pudo cargar el panel",
            message: "Comprueba tu conexión a internet e inténtalo de nuevo.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Reintentar", style: .default) { [weak self] _ in
            self?.webView.load(URLRequest(url: self?.url ?? URL(string: "https://whatsapp-sal-gvqunbuq.manus.space")!))
        })
        present(alert, animated: true)
    }
}
