//
//  UserOfZonesViewModel.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 29/03/23.
//

import Foundation

// MARK: - UserOfZonesViewModelDelegate
protocol ListUserOfZonesViewModelDelegate {
    func showUsers()
    func showError(errorDescription: String)
}

class UserOfZoneViewModel {
    let userOfZone: Usuario
    
    init(userOfZone: Usuario) {
        self.userOfZone = userOfZone
    }
    
    var idUsuario: Int {
        return userOfZone.idUsuario
    }
    var name: String {
        return userOfZone.name
    }
    var photo: String {
        return userOfZone.photo
    }
    var status: Int {
        return userOfZone.status
    }
    var fecha: String {
        return userOfZone.fecha
    }
    var hora: String {
        return userOfZone.hora
    }
}

class ListUserOfZonesViewModel {
    let idAdministrador: String
    var userOfZoneViewModelArray: [UserOfZoneViewModel] = []
    
    var delegate: ListUserOfZonesViewModelDelegate?
    
    init(idUser: String) {
        self.idAdministrador = idUser
        getUsers()
    }
    
    private func getUsers() {
        guard let resource = EncodeUserOfZones.createResource(viewModel: self) else { return }
        
        Api.fetch(resource: resource) { result in
            switch result {
            case .success(let model):
                if model.code == 0 {
                    self.userOfZoneViewModelArray = model.usuario.map(UserOfZoneViewModel.init)
                    self.delegate?.showUsers()
                } else {
                    self.delegate?.showError(errorDescription: model.message)
                }
            case .failure(let error):
                self.delegate?.showError(errorDescription: error.localizedDescription)
            }
        }
        
    }
    
}
