//
//  BaseView.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.
//

import UIKit

class BaseView: UIViewController {
    
    let interactor = Interactor()
    var error: String? {
        didSet{
            alert(.failure(false, completion: nil), title: error, buttonTitle: "حسنا")
            logError(error)
        }
    }
        
    func networkError(networkError: NSError?, completion: (() -> Void)?) -> Void {
        if networkError?.code == -1009 || networkError?.code == 13{
            // show error
        }else{
            error = networkError?.localizedDescription
        }
    }
    
    var headerTitle: String? {
        didSet{
            navigationItem.title = headerTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseSetupForUI()
    }
    
    func baseSetupForUI() {
        overrideUserInterfaceStyle = .light
        navigationController?.navigationBar.barTintColor = .primary
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
    
    deinit {
        logger((self.nibName?.description ?? "") + "  Was removed successfully from memory")
    }
    
    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    func openGoogleMap(location: Location) -> Void {
        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(location.lat),\(location.long)&directionsmode=driving"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }else{
            alert(.failure(false, completion: nil), title: "You can not open google map", body: "Make sure you have google map in your phone")
        }
    }
    
    func share(_ message: String) -> Void {
        let share = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        if let popOver = share.popoverPresentationController {
            popOver.sourceView = self.view
        }
        present(share, animated: true, completion: nil)
    }
    
    /// Enum for alert type
    ///
    /// - success: success alert
    /// - failure: failure alert
    /// - normal: normal alert
    ///
    /// - Author: Hammam Abdulaziz
    enum AlertType {
        case success
        case failure(_ withCancel: Bool,buttonTitle: String? = nil, completion: (() -> Void)?)
    }
    
    func alert(_ alertType: AlertType,
               title: String? = nil,
               body: String? = nil,
               dismissAfter: TimeInterval? = nil,
               buttonTitle: String? = "حسنا",
               completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        if let title = title{
            let titleFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
            alert.setValue(titleAttrString, forKey: "attributedTitle")
        }
        if let message = body{
            let messageFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
            alert.setValue(messageAttrString, forKey: "attributedMessage")
        }
        
        let ok = UIAlertAction(title: buttonTitle, style: .default) { (_) in
            completion?()
        }
        alert.addAction(ok)
        // Accessing alert view backgroundColor :
        switch alertType {
        case .success:
            break
        case .failure(let withCancelButton,let buttonTitle, let completion):
            if withCancelButton{
                let cancel = UIAlertAction(title: buttonTitle ?? "الغاء", style: .default) { (_) in
                    completion?()
                }
                alert.addAction(cancel)
            }
        }
        // Accessing buttons tintcolor :
        alert.view.tintColor = .black
        // presinting the alert controller ...
        present(alert, animated: true, completion: nil)
        
        if let timeToDismiss = dismissAfter {
            DispatchQueue.main.asyncAfter(deadline: .now() + timeToDismiss) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func refreshUi() {
        
    }
}

extension BaseView: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

extension BaseView: BaseViewProtocol{
    func didFailWithError(_ error: String) {
        self.error = error
    }
    
    func didFailWithNetworkError(_ error: NSError, completion: (() -> Void)?) {
        networkError(networkError: error, completion: completion)
    }
    
    func didFailWithError(_ error: NSError) {
        self.error = error.localizedDescription
    }
    
    func loading(_ start: Bool) {
        let loading = loadingView()
        start ? loading.startAnimation() : loading.stopAnimation()
    }
        
    func alert(title: String, buttonTitle: String, body: String, completion: (() -> Void)?) -> Void {
        alert(.failure(true, buttonTitle: buttonTitle, completion: completion), title: title, body: body)
    }
}
