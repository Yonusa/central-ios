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
    //var loginViewModel = LoginViewModel()
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
    
//    private let imageLogin: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "loginImage"))
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
    
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
        // textField.text = "yonusappios2@gmail.com"
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
        // textField.text = "Qwertyuiop0"
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
    
//    private lazy var buttonPassRecovery: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .clear
//        var attrs = [
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0),
//            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1843137255, green: 0.1803921569, blue: 0.2549019608, alpha: 1),
//            NSAttributedString.Key.underlineStyle: 1] as [NSAttributedString.Key: Any]
//        let buttonTitleStr = NSMutableAttributedString(string: "Recuperar Contraseña", attributes: attrs)
//        button.setAttributedTitle(buttonTitleStr, for: .normal)
//        button.addTarget(self, action: #selector(passRecovery), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var buttonCreateAccount: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .init(named: "BtnSec")
//        button.layer.cornerRadius = 20.0
//        button.setTitle("Crear Cuenta", for: .normal)
//        button.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
//        return button
//    }()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.shared.on(file: #file)
//
//        loginViewModel.delegate = self
        setupToHideKeyboardOnTapOnView()
        configureUI()
        checkPreviousLogin()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
    
    func checkPreviousLogin() {
//        spinner.showSpinner(onView: self.view)
//        loginViewModel.autologin()
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
        
        spinner.showSpinner(onView: self.view)
        
//        loginViewModel.attemptToLogin(email: email, password: password)
        
        let centralViewController = CentralViewController()
        self.navigationController?.pushViewController(centralViewController, animated: true)
    }
    
//    @objc private func passRecovery() {
////        let newVC = RecoverPasswordVC(nibName: "RecoverPasswordVC", bundle: nil)
//        self.navigationController?.pushViewController(newVC, animated: true)
//    }
//
//    @objc private func createAccount() {
////        let newVC = CreateAccountVC(nibName: "CreateAccountVC", bundle: nil)
//        self.navigationController?.pushViewController(newVC, animated: true)
//    }
    
}

//// MARK: - LoginViewModel Delegate
//extension LoginViewController: LoginViewModelDelegate {
//    func notAnInstaller() {
//        self.spinner.removeSpinner()
//        let newVC = AlertVC(nibName: "AlertVC", bundle: nil)
//        newVC.titleAlert = "Atención"
//        // swiftlint:disable line_length
//        newVC.message = "Está cuenta se actualizará y se convertirá en una cuenta de instalador\rAl continuar con este proceso tu cuenta quedará registrada como instalador. Ya no podrás acceder a Yonusa 2.0 ni 3.0"
//        newVC.cancelButtonIsHidden = false
//        newVC.buttonTitle = "Actualizar"
//        newVC.actionForOK = {
//            self.spinner.showSpinner(onView: self.view)
//            self.loginViewModel.updateAccount()
//        }
//        newVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.present(newVC, animated: true)
//    }
//
//    func loginSuccess() {
//        self.spinner.removeSpinner()
//        let newVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
//        self.navigationController?.pushViewController(newVC, animated: true)
//    }
//
//    func loginAccountNotActive(model: LoginModel) {
//        self.spinner.removeSpinner()
//        Alerts.actionAlert(controller: self, title: "Atención", message: model.mensaje, titleAction: "Activar") { _ in
//            let newVC = ActivateAccountVC(nibName: "ActivateAccountVC", bundle: nil)
//            newVC.email = model.email
//            newVC.userId = model.usuarioID
//            newVC.phone = model.telefono
//            self.navigationController?.pushViewController(newVC, animated: true)
//        }
//
//    }
//
//    func loginFailed(message: String) {
//        self.spinner.removeSpinner()
//        if !message.isEmpty {
//            Alerts.simpleAlert(controller: self, title: "Error", message: message)
//        }
//    }
//
//}
