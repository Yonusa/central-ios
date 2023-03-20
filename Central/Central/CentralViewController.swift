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
    var data = ["","","","","","","",""]
    // MARK: - Outlets
    private var collectionView: UICollectionView!
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.shared.on(file: #file)
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        self.view.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "Primary")
        self.navigationItem.title = "Central de Monitoreo"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "figure.walk.arrival"), style: .plain, target: self, action: #selector(logOut))
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
                                                                
    // MARK: - Actions
    @objc private func logOut() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc private func addUser() {
        let addUserView = ListUserViewController(nibName: "ListUserViewController", bundle: nil)
        self.navigationController?.pushViewController(addUserView, animated: true)
    }
    
}

// MARK: - CollectionViewDelegate
extension CentralViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ZonasCollectionViewCell {
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
