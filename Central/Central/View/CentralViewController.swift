//
//  CentralViewController.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 15/01/23.
//

import Foundation
import UIKit

class CentralViewController: UIViewController {
    
    // MARK: - Vars
    var idNode: String = ""
    private let spinner = Spinner()
    private let refreshControl = UIRefreshControl()
    private let listZonesViewModel = ListZonasViewModel()
    private let updateZonasViewModel = UpdateZonaViewModel()
    private var zones: [ZonaViewModel] = []
    // MARK: - Outlets
    private var collectionView: UICollectionView!
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.shared.on(file: #file)
        
        configureUI()
        configureValues()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        self.view.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "Primary")
        self.navigationItem.title = "Zonas"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.badge.plus"), style: .done, target: self, action: #selector(addUser))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "Third")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "Third")
        
        // create a layout to be used
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // make sure that there is a slightly larger gap at the top of each row
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        // set a standard item size of 60 * 60
        //layout.itemSize = CGSize(width: 60, height: 60)
        // the layout scrolls horizontally
        // layout.scrollDirection = .horizontal
        // set the frame and layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // set the view to be this UICollectionView
        self.view = collectionView
        
        //collectionView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor(named: "Background")
        
        let zonaViewCell = UINib(nibName: "ZonasCollectionViewCell", bundle: nil)
        self.collectionView.register(zonaViewCell, forCellWithReuseIdentifier: "cell")
        
    }
    
    private func configureValues() {
        collectionView.refreshControl = refreshControl
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(_:)), for: .valueChanged)
        listZonesViewModel?.delegate = self
        updateZonasViewModel.delegate = self
    }
                                                                
    // MARK: - Actions
    @objc private func addUser() {
        let addUserView = ListUserViewController(nibName: "ListUserViewController", bundle: nil)
        guard let idUser = listZonesViewModel?.idUser else { return }
        addUserView.idUser = String(idUser)
        self.navigationController?.pushViewController(addUserView, animated: true)
    }
    
    @objc private func refreshCollectionView(_ sender: Any) {
        listZonesViewModel?.refreshView()
    }
    
}

// MARK: - CollectionViewDelegate
extension CentralViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return zones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ZonasCollectionViewCell {
            cell.idUser = listZonesViewModel?.idUser
            cell.updateZonaViewModel = updateZonasViewModel
            cell.controllerView = self
            cell.zona = zones[indexPath.row]
            cell.configureUI()
            return cell
        } else {
            fatalError("Unable to dequeue subclassed cell")
        }
    }
    
    
}

extension CentralViewController: UICollectionViewDelegateFlowLayout {

    //Definiendo numero de columnas

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  10
        let columnsItems: CGFloat = 2
        let rowItems: CGFloat = 5
        let collectionViewSizeWidth = collectionView.frame.size.width - padding
        let collectionViewSizeHeight = collectionView.frame.size.height - padding

        return CGSize(width: collectionViewSizeWidth/columnsItems, height: collectionViewSizeHeight/rowItems)
    }
}

// MARK: - ListZonasViewModelDelegate
extension CentralViewController: ListZonasViewModelDelegate {
    func showZones() {
        self.refreshControl.endRefreshing()
        self.zones = listZonesViewModel?.zonasInNode(idNodo: idNode) ?? []
        self.collectionView.reloadData()
    }
    
    func showError(errorDescription: String) {
        self.refreshControl.endRefreshing()
        Alerts.simpleAlert(controller: self, title: "Error", message: errorDescription)
    }
    
}

// MARK: - UpdateZonasViewModelDelegate
extension CentralViewController: UpdateZonaViewModelDelegate {
    func updateZonesSuccess() {
        listZonesViewModel?.refreshView()
    }
    
}
