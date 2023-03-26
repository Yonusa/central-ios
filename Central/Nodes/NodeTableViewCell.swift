//
//  NodeTableViewCell.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 24/03/23.
//

import UIKit

class NodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageViewWiFi: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageViewBell: UIImageView!
    @IBOutlet weak var imageViewBattery: UIImageView!
    
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
    
}
