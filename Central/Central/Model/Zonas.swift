//
//  Zonas.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 26/03/23.
//

import Foundation

// MARK: - Zonas
struct Zonas: Codable {
    let zona: [Zona]
    let code: Int
    let message: String
}

// MARK: - Zona
struct Zona: Codable {
    let idNet, idNodo, idZona: String
    var ubicacion, nombre: String
    var coordinateX, coordinateY: String?
    var estado: String
    let alerta: String
}

// MARK: - EncodeZona
struct EncodeZona: Encodable {
    let idNet: String
    
    init(viewModel: ListNodesViewModel) {
        self.idNet = viewModel.idNet
    }
    
    static func createResource(viewModel: ListZonasViewModel) -> Resource<Zonas>? {
        guard let url = URL(string: Constansts.url + Constansts.zones + viewModel.idNet) else { return nil }
        
        var resource = Resource<Zonas>(url: url)
        resource.httpMethod = .get
        
//        guard let data = try? JSONEncoder().encode(EncodeNodes(viewModel: viewModel)) else { return nil }
//        resource.body = data
        
        return resource
    }
}

// MARK: - UpdateZone
struct UpdateZone: Codable {
    let code: Int
    let message: String
}

struct EncodeUpdateZone: Encodable {
    
    let idUsuario: String
    let idNet: String
    let idNodo: String
    let idZona: String
    let nombre: String
    let coordinateX: String
    let coordinateY: String
    let nombreReferencia: String
    let state: String
    
    init(viewModel: ZonaViewModel) {
        self.idUsuario = String(viewModel.idUser)
        self.idNet = viewModel.idNet
        self.idNodo = viewModel.idNodo
        self.idZona = viewModel.idZona
        self.nombre = viewModel.name
        self.coordinateX = viewModel.coordinateX
        self.coordinateY = viewModel.coordinateY
        self.nombreReferencia = viewModel.name
        self.state = viewModel.estado
    }
    
    static func createResource(viewModel: ZonaViewModel) -> Resource<UpdateZone>? {
        guard let url = URL(string: Constansts.url + Constansts.updateZone) else { return nil }
        
        var resource = Resource<UpdateZone>(url: url)
        resource.httpMethod = .put
        
        guard let data = try? JSONEncoder().encode(EncodeUpdateZone(viewModel: viewModel)) else { return nil }
        resource.body = data
        
        return resource
    }
    
}
