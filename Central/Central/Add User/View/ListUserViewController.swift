//
//  AddUserViewController.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 20/03/23.
//

import UIKit

class ListUserViewController: UIViewController {

    // MARK: - Vars
    var idUser: String!
    var listUsersOfZoneViewModel: ListUserOfZonesViewModel!
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Actions
    @objc func addUser() {
        let addUserView = AddUserViewController(nibName: "AddUserViewController", bundle: nil)
        addUserView.listUsersOfZoneViewModel = listUsersOfZoneViewModel
        self.navigationController?.present(addUserView, animated: true)
    }
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureValues()
    }
    
    private func configureUI() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .done, target: self, action: #selector(addUser))
        
        let tableViewCell = UINib(nibName: "ListUserTableViewCell", bundle: nil)
        tableView.register(tableViewCell, forCellReuseIdentifier: "cell")
        
    }
    
    private func configureValues() {
        tableView.delegate = self
        tableView.dataSource = self
        
        listUsersOfZoneViewModel = ListUserOfZonesViewModel(idUser: idUser)
        listUsersOfZoneViewModel.delegate = self
    }

}

// MARK: - TableViewDelegates
extension ListUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUsersOfZoneViewModel.userOfZoneViewModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListUserTableViewCell {
            cell.userOfZone = listUsersOfZoneViewModel.userOfZoneViewModelArray[indexPath.row]
            cell.configureUI()
            return cell
        } else {
            fatalError("Unable to dequeue subclassed cell")
        }
    }
    
    
}

extension ListUserViewController: ListUserOfZonesViewModelDelegate {
    func showUsers() {
        tableView.reloadData()
    }
    
    func showError(errorDescription: String) {
        Alerts.simpleAlert(controller: self, title: "Error", message: errorDescription)
    }
    
    
}
