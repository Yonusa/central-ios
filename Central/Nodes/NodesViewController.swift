//
//  NodesViewController.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 24/03/23.
//

import UIKit

class NodesViewController: UIViewController {

    // MARK: - Vars
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Actions
    @objc private func logOut() {
        self.navigationController?.popToRootViewController(animated: true)
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
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "Third")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "Third")
        
        let tableViewCell = UINib(nibName: "NodeTableViewCell", bundle: nil)
        tableView.register(tableViewCell, forCellReuseIdentifier: "cell")
        
    }
    
    private func configureValues() {
        tableView.dataSource = self
        tableView.delegate = self
    }

}

// MARK: - TableViewDelegates

extension NodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NodeTableViewCell {
            return cell
        } else {
            fatalError("Unable to dequeue subclassed cell")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let centralViewController = CentralViewController()
        self.navigationController?.pushViewController(centralViewController, animated: true)
    }
    
    
}
