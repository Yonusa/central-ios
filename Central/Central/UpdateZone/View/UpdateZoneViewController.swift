//
//  UpdateZoneViewController.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 02/04/23.
//

import UIKit

class UpdateZoneViewController: UIViewController {
    
    
    // MARK: - Vars
    
    // MARK: - Outlets
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var buttonUpdateInfo: UIButton!
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        textFieldConfig(textFieldName, placeholder: "Nombre", keyboardType: .default)
        textFieldConfig(textFieldLocation, placeholder: "Ubicación", keyboardType: .default)
        
        buttonUpdateInfo.backgroundColor = .init(named: "Primary")
        buttonUpdateInfo.layer.cornerRadius = 20.0
        buttonUpdateInfo.layer.shadowColor = UIColor.black.cgColor
        buttonUpdateInfo.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        buttonUpdateInfo.layer.shadowRadius = 8
        buttonUpdateInfo.layer.shadowOpacity = 0.5
        buttonUpdateInfo.setTitle("Actualizar información", for: .normal)
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
        
    }
    
    // MARK: - Actions
    @IBAction func updateInfo(_ sender: Any) {
    }
    

}
