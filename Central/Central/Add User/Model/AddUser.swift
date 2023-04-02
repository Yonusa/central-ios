//
//  AddUser.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 01/04/23.
//

import Foundation

// MARK: - AddUser
struct AddUser: Codable {
    let code: Int
    let message: String
}

// MARK: - EncodeAddUser
struct EncodeAddUser: Encodable {
    let name: String
    let password: String
    let email: String
    let telefono: String
    let idRol: Int
    let idNet: String
    let idAdmin: String
    
    init(viewModel: AddUserViewModel) {
        self.name = viewModel.name
        self.password = viewModel.password
        self.email = viewModel.email
        self.telefono = viewModel.telefono
        self.idNet = viewModel.idNet
        self.idRol = viewModel.idRol
        self.idAdmin = viewModel.idAdmin
    }
    
    static func createResource(viewModel: AddUserViewModel) -> Resource<AddUser>? {
        guard let url = URL(string: Constansts.url + Constansts.addUser) else { return nil }
        
        var resource = Resource<AddUser>(url: url)
        resource.httpMethod = .post
        guard let body = try? JSONEncoder().encode(EncodeAddUser(viewModel: viewModel)) else { return nil }
        resource.body = body
        
        return resource
        
    }
    
  }
