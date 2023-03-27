//
//  LoginViewController.swift
//  Yonusa Instaladores
//
//  Created by Yonusa iOS on 21/04/22.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {
    
    // MARK: - Vars
    var loginViewModel = LoginViewModel()
    var spinner = Spinner()
    
    // MARK: - Outlets
    private let backgroundImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "BackgroundLogin"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let iamgeLoginAnimation: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loginAnimation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play()
        return animationView
    }()
    
    private let labelLogin: UILabel = {
        let label = UILabel()
        label.text = "Inicia Sesión"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let textFieldEmail: UITextField = {
        let textField = UITextField()
        textField.setRightPaddingPoints(20)
        textField.setLeftPaddingPoints(20)
        textField.placeholder = "Ingresa tu correo"
        textField.layer.cornerRadius = 20.0
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
         textField.text = "admin@gmail.com"
        return textField
    }()
    
    private let textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.setRightPaddingPoints(20)
        textField.setLeftPaddingPoints(20)
        textField.placeholder = "Ingresa tu contraseña"
        textField.layer.cornerRadius = 20.0
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        textField.layer.borderWidth = 1.0
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
         textField.text = "admin"
        return textField
    }()
    
    private lazy var buttonLogin: UIButton = {
        let button = UIButton()
        button.backgroundColor = .init(named: "Primary")
        button.layer.cornerRadius = 20.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.5
        button.setTitle("Iniciar Sesión", for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.shared.on(file: #file)
        
        setupToHideKeyboardOnTapOnView()
        configureUI()
        configureValues()
        checkPreviousLogin()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Helpers
    private func configureUI() {
        
        view.addSubview(backgroundImageView)
        backgroundImageView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        let generalStackView = UIStackView(arrangedSubviews: [
            iamgeLoginAnimation,
            labelLogin,
            textFieldEmail,
            textFieldPassword,
            buttonLogin,
//            buttonCreateAccount,
//            buttonPassRecovery
        ])
        generalStackView.axis = .vertical
        generalStackView.alignment = .center
        generalStackView.distribution = .fill
        generalStackView.spacing = 20
        view.addSubview(generalStackView)
        
        // swiftlint:disable line_length
        generalStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 20, paddingRight: 20)
        
        iamgeLoginAnimation.anchor(width: 200, height: 200)
        labelLogin.anchor(left: generalStackView.leftAnchor, right: generalStackView.rightAnchor, paddingLeft: 20, paddingRight: 20, height: 40)
        textFieldEmail.anchor(left: generalStackView.leftAnchor, right: generalStackView.rightAnchor, paddingLeft: 20, paddingRight: 20, height: 40)
        textFieldPassword.anchor(left: generalStackView.leftAnchor, right: generalStackView.rightAnchor, paddingLeft: 20, paddingRight: 20, height: 40)
        buttonLogin.anchor(left: generalStackView.leftAnchor, right: generalStackView.rightAnchor, paddingLeft: 20, paddingRight: 20, height: 40)
//        buttonCreateAccount.anchor(left: generalStackView.leftAnchor, right: generalStackView.rightAnchor, paddingLeft: 20, paddingRight: 20, height: 40)
//        buttonPassRecovery.anchor(left: generalStackView.leftAnchor, right: generalStackView.rightAnchor, paddingLeft: 20, paddingRight: 20, height: 40)
        // swiftlint:enable line_length
        
    }
    
    private func configureValues() {
        loginViewModel.delegate = self
    }
    
    func checkPreviousLogin() {
        spinner.showSpinner(onView: self.view)
        loginViewModel.autoLogin()
    }
    
    // MARK: - Selectors
    
    @objc private func login() {
        guard let email = textFieldEmail.text, !email.isEmpty else {
            Alerts.simpleAlert(controller: self, title: "Atención", message: "Por favor ingresa tu usuario")
            return
        }
        guard let password = textFieldPassword.text, !password.isEmpty else {
            Alerts.simpleAlert(controller: self, title: "Atención", message: "Por favor ingresa tu contraseña")
            return
        }
        
        // Attempt to Login
        spinner.showSpinner(onView: self.view)
        loginViewModel.login(email: email, password: password)
        
    }
    
}

// MARK: - LoginViewModel Delegate
extension LoginViewController: LoginViewModelDelegate {
    func removeSpinner() {
        self.spinner.removeSpinner()
    }
    
    func showError(errorDescription: String) {
        self.spinner.removeSpinner()
        Alerts.simpleAlert(controller: self, title: "Error", message: errorDescription)
    }

    func loginSuccess() {
        self.spinner.removeSpinner()
        navigationController?.setNavigationBarHidden(false, animated: true)
        let nodesViewController = NodesViewController()
        self.navigationController?.pushViewController(nodesViewController, animated: true)
    }

}
