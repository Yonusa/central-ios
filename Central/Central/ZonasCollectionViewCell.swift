//
//  ZonasCollectionViewCell.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 29/01/23.
//

import UIKit

class ZonasCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelZona: UILabel!
    @IBOutlet weak var imageSwitch: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20.0
        self.backgroundColor = .white
    }

    @IBAction func configControl(_ sender: Any) {
        
    }
    
    @IBAction func zoneLocation(_ sender: Any) {
        
    }
}
