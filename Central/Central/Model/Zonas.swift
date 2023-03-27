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
    let idNet, idNodo, idZona, nombre: String
    let ubicacion: String
    let coordinateX, coordinateY: String?
    let estado: String
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
