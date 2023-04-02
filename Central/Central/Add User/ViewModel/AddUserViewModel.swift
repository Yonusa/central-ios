//
//  AddUserViewModel.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 01/04/23.
//

import Foundation

protocol AddUserViewModelDelegate {
    func userAddSuccess()
    func showError(errorDescription: String)
}

class AddUserViewModel {
    
    var name: String = ""
    var password: String = ""
    var email: String = ""
    var telefono: String = ""
    var idNet: String = ""
    var idAdmin: String = ""
    var idRol: Int = 0
    
    var delegate: AddUserViewModelDelegate?
    
    init?() {
        guard let userData = LoginViewModel.getUserData() else { return nil }
        guard let idNet = userData.idNet else { return nil }
        self.idAdmin = String(userData.idUser)
        self.idNet = idNet
    }
    
    func setData(name: String, password: String, email: String, telefono: String, idRol: Int) {
        self.name = name
        self.password = password
        self.email = email
        self.telefono = telefono
        self.idRol = idRol
        addUser()
    }
    
    private func addUser() {
        guard let resource = EncodeAddUser.createResource(viewModel: self) else { return }
        
        Api.fetch(resource: resource) { result in
            switch result {
            case .success(let model):
                if model.code == 0 {
                    self.delegate?.userAddSuccess()
                } else {
                    self.delegate?.showError(errorDescription: model.message)
                }
            case .failure(let error):
                self.delegate?.showError(errorDescription: error.localizedDescription)
            }
        }
    }
    
}
