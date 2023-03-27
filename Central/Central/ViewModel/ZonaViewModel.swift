//
//  ZonaViewModel.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 26/03/23.
//

import Foundation

// MARK: - NodeViewModel
class ZonaViewModel {
    let zona: Zona
    
    init(zona: Zona) {
        self.zona = zona
    }
    
    var idNet: String {
        return zona.idNet
    }
    var idNodo: String {
        return zona.idNodo
    }
    var idZona: String {
        return zona.idZona
    }
    var name: String {
        return zona.nombre
    }
    var location: String {
        return zona.ubicacion
    }
    var coordinateX: String {
        return zona.coordinateX ?? ""
    }
    var coordinateY: String {
        return zona.coordinateY ?? ""
    }
    var estado: String {
        return zona.estado
    }
    var alerta: String {
        return zona.alerta
    }
}

// MARK: - ListZonasViewModelDelegate
protocol ListZonasViewModelDelegate {
    func showZones()
    func showError(errorDescription: String)
}

// MARK: - ListNodesViewModel
class ListZonasViewModel {
    let idNet: String
    var zoneViewModelArray: [ZonaViewModel] = []
    
    var delegate: ListZonasViewModelDelegate?
    
    init?() {
        guard let userData = LoginViewModel.getUserData() else { return nil }
        guard let idNet = userData.idNet else { return nil }
        self.idNet = idNet
        self.requestZones()
    }
    
    private func requestZones() {
        guard let resource = EncodeZona.createResource(viewModel: self) else { return }
        
        Api.fetch(resource: resource) { result in
            switch result {
            case .success(let model):
                self.zoneViewModelArray = model.zona.map(ZonaViewModel.init)
            case .failure(let error):
                self.delegate?.showError(errorDescription: error.localizedDescription)
            }
        }
        
    }
    
    func refreshView() {
        requestZones()
    }
    
    func zonasInNode(idNodo: String) -> [ZonaViewModel] {
        return zoneViewModelArray.filter { $0.idNodo.elementsEqual(idNodo) }
    }
    
}
