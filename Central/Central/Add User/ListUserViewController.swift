//
//  AddUserViewController.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 20/03/23.
//

import UIKit

class ListUserViewController: UIViewController {

    // MARK: - Vars
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Actions
    @objc func addUser() {
        let addUserView = AddUserViewController(nibName: "AddUserViewController", bundle: nil)
        self.navigationController?.present(addUserView, animated: true)
    }
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .done, target: self, action: #selector(addUser))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let tableViewCell = UINib(nibName: "ListUserTableViewCell", bundle: nil)
        tableView.register(tableViewCell, forCellReuseIdentifier: "cell")
        
    }

}

// MARK: - TableViewDelegates
extension ListUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListUserTableViewCell {
            return cell
        } else {
            fatalError("Unable to dequeue subclassed cell")
        }
    }
    
    
}
