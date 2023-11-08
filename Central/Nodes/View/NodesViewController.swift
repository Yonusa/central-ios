//
//  NodesViewController.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 24/03/23.
//

import UIKit

class NodesViewController: UIViewController {

    // MARK: - Vars
    private let listNodesViewModel = ListNodesViewModel()
    private let listZonesViewModel = ListZonasViewModel()
    private let refreshControl = UIRefreshControl()
    private var closeSessionViewModel: CloseSessionViewModel!
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Actions
    @objc private func logOut() {
        closeSessionViewModel.logout()
    }
    @objc private func refreshTableView(_ sender: Any) {
        listNodesViewModel?.refreshView()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureValues()
    }
    
    private func configureUI() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "Primary")
        self.navigationItem.title = "Nodos"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "figure.walk.arrival"), style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.magnifyingglass"), style: .done, target: self, action: #selector(showAllZonesLocations))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "Third")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "Third")
        
        let tableViewCell = UINib(nibName: "NodeTableViewCell", bundle: nil)
        tableView.register(tableViewCell, forCellReuseIdentifier: "cell")
        
    }
    
    private func configureValues() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        
        guard let listNodesViewModel = listNodesViewModel else { return }
        listNodesViewModel.delegate = self
        
        closeSessionViewModel = CloseSessionViewModel(idUser: listNodesViewModel.idUser)
        closeSessionViewModel.delegate = self
        
    }
    
    @objc private func showAllZonesLocations() {
        guard let mapItems = listZonesViewModel?.allZonesLocations() else { return }
        MapsHandler.openMapsApp(mapItems: mapItems)
    }

}

// MARK: - TableViewDelegates

extension NodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNodesViewModel?.nodeViewModelArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NodeTableViewCell {
            cell.node = listNodesViewModel?.node(at: indexPath.row)
            cell.configureUI()
            return cell
        } else {
            fatalError("Unable to dequeue subclassed cell")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let centralViewController = CentralViewController()
        guard let nodeViewModel = listNodesViewModel?.node(at: indexPath.row) else { return }
        centralViewController.idNode = nodeViewModel.idNodo
        self.navigationController?.pushViewController(centralViewController, animated: true)
    }
    
    
}

// MARK: - ListNodesViewModelDelegate
extension NodesViewController: ListNodesViewModelDelegate {
    func showNodes() {
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
    }
    
    func showError(errorDescription: String) {
        self.refreshControl.endRefreshing()
        Alerts.simpleAlert(controller: self, title: "Error", message: errorDescription)
    }

}

// MARK: - CloseSessionDelegate
extension NodesViewController: CloseSessionViewModelDelegate {
    func logoutSuccess() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
