//
//  AddUserViewController.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 20/03/23.
//

import UIKit

enum PickerData: String, CaseIterable {
    case admon = "Administrador"
    case invited = "Invited"
    case monitorist = "Monitorista"
    
    // If you add another case, don't forget to add it into the array
    static let array = [admon, invited, monitorist]
    
    var value: Int {
        switch self {
        case .admon:
            return 1
        case .invited:
            return 2
        case .monitorist:
            return 3
        }
    }
}

class AddUserViewController: UIViewController {

    // MARK: - Vars
    let spinner = Spinner()
    // MARK: - Outlets
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldPhone: UITextField!
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPass: UITextField!
    @IBOutlet weak var buttonAddUser: UIButton!
    @IBOutlet weak var textfieldIdRol: UITextField!
    let thePicker = UIPickerView()
    
    let addUserViewModel = AddUserViewModel()
    var listUsersOfZoneViewModel: ListUserOfZonesViewModel!
    // MARK: - Actions
    
    @IBAction func addUser(_ sender: Any) {
        checkEmptyvalues()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureValues()
    }
    
    private func configureUI() {
        textFieldConfig(textfieldName, placeholder: "Nombre", keyboardType: .default)
        textFieldConfig(textfieldPhone, placeholder: "Teléfono", keyboardType: .phonePad)
        textFieldConfig(textfieldEmail, placeholder: "correo electrónico", keyboardType: .emailAddress)
        textFieldConfig(textfieldPass, placeholder: "Contraseña", keyboardType: .default)
        textFieldConfig(textfieldIdRol, placeholder: "Tipo de usuario", keyboardType: .default)
        
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
    
    private func configureValues() {
        addUserViewModel?.delegate = self
        textfieldIdRol.inputView = thePicker
        thePicker.delegate = self
    }
    
    private func checkEmptyvalues() {
        guard let name = textfieldName.text, !name.isEmpty,
              let password = textfieldPass.text, !password.isEmpty,
              let email = textfieldEmail.text, !email.isEmpty,
              let phone = textfieldPhone.text, !phone.isEmpty,
              let idRolText = textfieldIdRol.text, !idRolText.isEmpty
        
        else {
            Alerts.simpleAlert(controller: self, title: "Error", message: "Por favor ingresa todos los datos ")
            return
        }
        
        if let selectedRol = PickerData(rawValue: idRolText) {
            spinner.showSpinner(onView: self.view)
            addUserViewModel?.setData(name: name, password: password, email: email, telefono: phone, idRol: selectedRol.value)
        }
    }

}

// MARK: - AddUserViewModelDelegate
extension AddUserViewController: AddUserViewModelDelegate {
    func userAddSuccess() {
        self.spinner.removeSpinner()
        self.listUsersOfZoneViewModel.refreshUsers()
        self.dismiss(animated: true)
    }
    
    func showError(errorDescription: String) {
        self.spinner.removeSpinner()
        Alerts.simpleAlert(controller: self, title: "Error", message: errorDescription)
    }
    
}

// MARK: - PickerDelegate
extension AddUserViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerData.allCases.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PickerData.array[row].rawValue
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textfieldIdRol.text = PickerData.array[row].rawValue
        self.view.endEditing(true)
    }
    
}
