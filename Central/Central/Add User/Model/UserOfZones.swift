//
//  UserOfZones.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 29/03/23.
//

import Foundation

// MARK: - UserOfZones
struct UserOfZones: Codable {
    let usuario: [Usuario]
    let code: Int
    let message: String
}

// MARK: - Usuario
struct Usuario: Codable {
    let idUsuario: Int
    let name, photo: String
    let status: Int
    let fecha, hora: String
}

// MARK: - EncodeUserOfZones
struct EncodeUserOfZones {
    let idAdministrador: String
    
    init(viewModel: ListUserOfZonesViewModel) {
        self.idAdministrador = viewModel.idAdministrador
    }
    
    static func createResource(viewModel: ListUserOfZonesViewModel) -> Resource<UserOfZones>? {
        guard let url = URL(string: Constansts.url + Constansts.usersOfZone + viewModel.idAdministrador) else { return nil }
        
        var resource = Resource<UserOfZones>(url: url)
        resource.httpMethod = .get
        
//        guard let data = try? JSONEncoder().encode(EncodeNodes(viewModel: viewModel)) else { return nil }
//        resource.body = data
        
        return resource
    }
}
