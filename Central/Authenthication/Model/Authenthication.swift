//
//  Authenthication.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 25/03/23.
//

import Foundation



// MARK: - Decode Authenthication
struct Authenthication: Codable {
    let idUser: Int
    let name, photo, idNet: String?
    let idRol, isAdmin: Int
    let horaSesion: String?
    let code: Int
    let message: String
}

// MARK: - Encode Authenthication
struct EncodeAuthenthication: Encodable {
    let email: String
    let password: String
    let token: String = ""
    
    init(viewModel: LoginViewModel) {
        self.email = viewModel.email
        self.password = viewModel.password
    }
    
    static func createResource(viewModel: LoginViewModel) -> Resource<Authenthication>? {
        guard let url = URL(string: Constansts.url + Constansts.login) else { return nil }
        
        var resource = Resource<Authenthication>(url: url)
        resource.httpMethod = .post
        
        guard let data = try? JSONEncoder().encode(EncodeAuthenthication(viewModel: viewModel)) else { return nil }
        resource.body = data
        
        return resource
    }

}

// MARK: - CloseSession
struct CloseSession: Codable {
    let code: Int
    let message: String
}

struct EncodeCloseSession: Encodable {
    
    static func createResource(idUser: String) -> Resource<CloseSession>? {
        guard let url = URL(string: Constansts.url + Constansts.logout + idUser) else { return nil }
        
        var resource = Resource<CloseSession>(url: url)
        resource.httpMethod = .post
        
//        guard let data = try? JSONEncoder().encode(idUser) else { return nil }
//        resource.body = data
        
        return resource
    }
    
}
