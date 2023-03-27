//
//  NodeTableViewCell.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 24/03/23.
//

import UIKit

enum BatteryImage: String {
    case full = "battery.100"
    case low = "battery.25"
    case charge = "battery.100.bolt"
}

enum WiFiImage: String {
    case connected = "wifi"
    case disconnected = "no-wifi"
}

class NodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet weak private var imageViewWiFi: UIImageView!
    @IBOutlet weak private var labelDescription: UILabel!
    @IBOutlet weak private var imageViewBell: UIImageView!
    @IBOutlet weak private var imageViewBattery: UIImageView!
    
    var node: NodeViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.layer.cornerRadius = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func configureUI() {
        // Set WiFi state
        if node.statusNodo == "1" {
            imageViewWiFi.image = UIImage(named: WiFiImage.connected.rawValue)
        } else {
            imageViewWiFi.image = UIImage(named: WiFiImage.disconnected.rawValue)
        }
        // Set Alert
        if node.alertas > 0 {
            imageViewBell.isHidden = false
        } else {
            imageViewBell.isHidden = true
        }
        // Set Battery Image
        switch node.battery {
        case 0:
            imageViewBattery.image = UIImage(systemName: BatteryImage.full.rawValue)
        case 1:
            imageViewBattery.image = UIImage(systemName: BatteryImage.low.rawValue)
        default:
            imageViewBattery.image = UIImage(systemName: BatteryImage.full.rawValue)
        }
        // Set Message
        labelDescription.text = node.mensaje
        
    }
    
}
