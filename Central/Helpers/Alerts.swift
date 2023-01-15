//
//  Alerts.swift
//  Yonusa Instaladores
//
//  Created by Yonusa iOS on 26/04/22.
//

import Foundation
import UIKit

struct Alerts {
    static func simpleAlert(controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            controller.present(alert, animated: true)
        }
    }
    
    static func actionAlert(controller: UIViewController, title: String, message: String, titleAction: String, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: titleAction, style: .default, handler: handler))
        DispatchQueue.main.async {
            controller.present(alert, animated: true)
        }
                        
    }
    
    // Alert to Settings
    static func settingsAlert (controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Continuar", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        controller.present(alert, animated: true, completion: nil)
    }
}
