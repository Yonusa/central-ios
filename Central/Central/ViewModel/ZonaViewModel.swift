//
//  ZonaViewModel.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 26/03/23.
//

import Foundation

// MARK: - UpdateZonaVieModelDelegate
protocol UpdateZonaViewModelDelegate {
    func updateZonesSuccess()
    func showError(errorDescription: String)
}

// MARK: - NodeViewModel
class ZonaViewModel {
    let zona: Zona
    
    // For Update Zone Only
    var idUser: Int = 0
    
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

// MARK: - UpdateZone
class UpdateZonaViewModel {
    var delegate: UpdateZonaViewModelDelegate?
    
    func updateZone(idUser: Int, viewModel: ZonaViewModel, coordinateX: String? = nil, coordinateY: String? = nil, nombre: String? = nil, estado: String? = nil) {
        var zona = viewModel.zona
        
        if let coordinateX = coordinateX {
            zona.coordinateX = coordinateX
        }
        if let coordinateY = coordinateY {
            zona.coordinateY = coordinateY
        }
        if let nombre = nombre {
            zona.nombre = nombre
        }
        if let estado = estado {
            zona.estado = estado
        } else {
            if zona.estado == ZoneState.on.rawValue {
                zona.estado = "1"
            } else {
                zona.estado = "0"
            }
        }
        
        let viewModel = ZonaViewModel(zona: zona)
        viewModel.idUser = idUser
        requestUpdate(viewModel: viewModel)
    }
    
    private func requestUpdate(viewModel: ZonaViewModel) {
        guard let resource = EncodeUpdateZone.createResource(viewModel: viewModel) else { return }
        
        Api.fetch(resource: resource) { result in
            switch result {
            case .success(let model):
                if model.code == 0 {
                    self.delegate?.updateZonesSuccess()
                } else {
                    self.delegate?.showError(errorDescription: model.message)
                }
                
            case .failure(let error):
                self.delegate?.showError(errorDescription: error.localizedDescription)
            }
        }
        
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
    let idUser: Int
    var zoneViewModelArray: [ZonaViewModel] = []
    
    var delegate: ListZonasViewModelDelegate?
    
    init?() {
        guard let userData = LoginViewModel.getUserData() else { return nil }
        guard let idNet = userData.idNet else { return nil }
        self.idNet = idNet
        self.idUser = userData.idUser
        self.requestZones()
    }
    
    private func requestZones() {
        guard let resource = EncodeZona.createResource(viewModel: self) else { return }
        
        Api.fetch(resource: resource) { result in
            switch result {
            case .success(let model):
                self.zoneViewModelArray = model.zona.map(ZonaViewModel.init)
                self.delegate?.showZones()
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
    
    func allZonesLocations() -> [MapItems] {
        var mapItems: [MapItems] = []
        for zone in zoneViewModelArray {
            let mapItem = MapItems(latitud: zone.coordinateY, longitud: zone.coordinateX, zoneName: zone.name)
            mapItems.append(mapItem)
        }
        return mapItems
    }
    
}
