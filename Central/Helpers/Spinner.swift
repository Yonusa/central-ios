//
//  Alerts.swift
//  Yonusa Instaladores
//
//  Created by Yonusa iOS on 26/04/22.
//

import UIKit

final class Spinner {
    
    var spinner: UIView?
    
    func showSpinner(onView: UIView) {
        // If Spinner Exists, don't create another one
        if spinner != nil {
            return
        }
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        spinner = spinnerView
    }
    
    func removeSpinner() {
        if spinner == nil {
            return
        }
        
        DispatchQueue.main.async {
            self.spinner?.removeFromSuperview()
            self.spinner = nil
        }
    }
}
