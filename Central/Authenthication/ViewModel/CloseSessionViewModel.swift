//
//  CloseSessionViewModel.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 01/04/23.
//

import Foundation

protocol CloseSessionViewModelDelegate {
    func logoutSuccess()
    func showError(errorDescription: String)
}

struct CloseSessionViewModel {
    
    private let idUser: String
    
    var delegate: CloseSessionViewModelDelegate?
    
    init(idUser: String) {
        self.idUser = idUser
    }
    
    func logout() {
        guard let resource = EncodeCloseSession.createResource(idUser: idUser) else { return }
        
        Api.fetch(resource: resource) { result in
            switch result {
                
            case .success(let model):
                if model.code == 0 {
                    clearUserDefaults()
                    self.delegate?.logoutSuccess()
                } else {
                    self.delegate?.showError(errorDescription: model.message)
                }
            case .failure(let error):
                self.delegate?.showError(errorDescription: error.localizedDescription)
            }
        }
    }
    
    private func clearUserDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
    
}
