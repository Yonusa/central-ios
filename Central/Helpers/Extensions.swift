//
//  Extensions.swift
//  Yonusa Instaladores
//
//  Created by Yonusa iOS on 22/04/22.
//

import UIKit

// MARK: - View Anchors
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let activeTop = top {
            topAnchor.constraint(equalTo: activeTop, constant: paddingTop).isActive = true
        }
        
        if let activeLeft = left {
            leftAnchor.constraint(equalTo: activeLeft, constant: paddingLeft).isActive = true
        }
        
        if let activeBottom = bottom {
            bottomAnchor.constraint(equalTo: activeBottom, constant: -paddingBottom).isActive = true
        }
        
        if let activeRight = right {
            rightAnchor.constraint(equalTo: activeRight, constant: -paddingRight).isActive = true
        }
        
        if let activeWidth = width {
            widthAnchor.constraint(equalToConstant: activeWidth).isActive = true
        }
        
        if let activeHeight = height {
            heightAnchor.constraint(equalToConstant: activeHeight).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = true
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    func addConstraintsToFillView(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
}

// MARK: - TextField Padding
extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        func setRightPaddingPoints(_ amount: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
}

// MARK: - Dismiss Keyboard
extension UIViewController {
    func setupToHideKeyboardOnTapOnView() {
        let tapOutside = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapOutside.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOutside)
    }

    @objc func dismissKeyboard() {
        print("dismissing...")
        view.endEditing(true)
    }
}
