//
//  AddUserViewController.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 20/03/23.
//

import UIKit

class AddUserViewController: UIViewController {

    // MARK: - Vars
    
    // MARK: - Outlets
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldPhone: UITextField!
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPass: UITextField!
    @IBOutlet weak var buttonAddUser: UIButton!
    // MARK: - Actions
    
    @IBAction func addUser(_ sender: Any) {
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        textFieldConfig(textfieldName, placeholder: "Nombre", keyboardType: .default)
        textFieldConfig(textfieldPhone, placeholder: "Teléfono", keyboardType: .phonePad)
        textFieldConfig(textfieldEmail, placeholder: "correo electrónico", keyboardType: .emailAddress)
        textFieldConfig(textfieldPass, placeholder: "Contraseña", keyboardType: .default)
        
        buttonAddUser.backgroundColor = .init(named: "Primary")
        buttonAddUser.layer.cornerRadius = 20.0
        buttonAddUser.layer.shadowColor = UIColor.black.cgColor
        buttonAddUser.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        buttonAddUser.layer.shadowRadius = 8
        buttonAddUser.layer.shadowOpacity = 0.5
        buttonAddUser.setTitle("Agregar Usuario", for: .normal)
    }
    
    private func textFieldConfig(_ textField: UITextField, placeholder: String, keyboardType: UIKeyboardType) {
        textField.setRightPaddingPoints(20)
        textField.setLeftPaddingPoints(20)
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 20.0
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = keyboardType
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
    }

}
