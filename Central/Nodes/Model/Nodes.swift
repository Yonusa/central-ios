//
//  Nodes.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 26/03/23.
//

import Foundation

// MARK: - Nodes
struct Nodes: Codable {
    let code: Int
    let idNet: String?
    let message: String
    let idNodos: [IDNodo]?
}

// MARK: - IDNodo
struct IDNodo: Codable {
    let idNodo, statusNodo: String
    let alertas: Int
    let mensaje: String
    let batery: Int
}

// MARK: - EncodeNodes
struct EncodeNodes: Encodable {
    let idNet: String
    
    init(viewModel: ListNodesViewModel) {
        self.idNet = viewModel.idNet
    }
    
    static func createResource(viewModel: ListNodesViewModel) -> Resource<Nodes>? {
        guard let url = URL(string: Constansts.url + Constansts.nodes + viewModel.idNet) else { return nil }
        
        var resource = Resource<Nodes>(url: url)
        resource.httpMethod = .get
        
//        guard let data = try? JSONEncoder().encode(EncodeNodes(viewModel: viewModel)) else { return nil }
//        resource.body = data
        
        return resource
    }

}

