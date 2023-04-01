//
//  NodesViewModel.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 26/03/23.
//

import Foundation

// MARK: - NodeViewModel
class NodeViewModel {
    let node: IDNodo
    
    init(node: IDNodo) {
        self.node = node
    }
    
    var idNodo: String {
        return node.idNodo
    }
    var statusNodo: String {
        return node.statusNodo
    }
    var alertas: Int {
        return node.alertas
    }
    var mensaje: String {
        return node.mensaje
    }
    var battery: Int {
        return node.batery
    }
}

// MARK: - ListNodesViewModelDelegate
protocol ListNodesViewModelDelegate {
    func showNodes()
    func showError(errorDescription: String)
}

// MARK: - ListNodesViewModel
class ListNodesViewModel {
    let idUser: String
    let idNet: String
    var nodeViewModelArray: [NodeViewModel] = []
    
    var delegate: ListNodesViewModelDelegate?
    init?() {
        guard let userData = LoginViewModel.getUserData() else { return nil }
        guard let idNet = userData.idNet else { return nil }
        self.idUser = String(userData.idUser)
        self.idNet = idNet
        self.requestNodes()
    }
    
    private func requestNodes() {
        guard let resource = EncodeNodes.createResource(viewModel: self) else { return }
        
        Api.fetch(resource: resource) { result in
            switch result {
            case .success(let model):
                if model.code == 0 {
                    guard let idNodos = model.idNodos else { return }
                    self.nodeViewModelArray = idNodos.map(NodeViewModel.init)
                    self.delegate?.showNodes()
                } else {
                    self.delegate?.showError(errorDescription: model.message)
                }
                
            case .failure(let error):
                self.delegate?.showError(errorDescription: error.localizedDescription)
            }
        }
    }
    
    func refreshView() {
        requestNodes()
    }
    
    func node(at: Int) -> NodeViewModel {
        return nodeViewModelArray[at]
    }
    
}
