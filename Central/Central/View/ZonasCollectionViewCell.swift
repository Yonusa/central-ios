//
//  ZonasCollectionViewCell.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 29/01/23.
//

import UIKit

enum ZoneState: String {
    case on = "ON"
    case off = "OFF"
    case none = ""
    
}

enum ZonaImage: String {
    case on = "on"
    case off = "off"
    case none = "disable"
}

class ZonasCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var labelZona: UILabel!
    @IBOutlet weak private var imageSwitch: UIImageView!
    
    var idUser: Int!
    var zona: ZonaViewModel!
    var updateZonaViewModel: UpdateZonaViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20.0
        self.backgroundColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageSwitch.isUserInteractionEnabled = true
        imageSwitch.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureUI() {
        // Set Name of Zone
        labelZona.text = zona.name
        // Set State of Zone
        if zona.estado == ZoneState.on.rawValue {
            imageSwitch.image = UIImage(named: ZonaImage.on.rawValue)
            return
        }
        if zona.estado == ZoneState.off.rawValue {
            imageSwitch.image = UIImage(named: ZonaImage.off.rawValue)
            return
        }
        if zona.estado == ZoneState.none.rawValue {
            imageSwitch.image = UIImage(named: ZonaImage.none.rawValue)
            return
        }
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if zona.estado == ZoneState.on.rawValue {
            updateZonaViewModel.updateZone(idUser: idUser, viewModel: zona, estado: "0")
            return
        }
        if zona.estado == ZoneState.off.rawValue {
            updateZonaViewModel.updateZone(idUser: idUser, viewModel: zona, estado: "1")
            return
        }

    }

    @IBAction func configControl(_ sender: Any) {
        
    }
    
    @IBAction func zoneLocation(_ sender: Any) {
        
    }
}
