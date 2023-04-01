//
//  ListUserTableViewCell.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 20/03/23.
//

import UIKit

class ListUserTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var labelUser: UILabel!
    @IBOutlet weak var labelLastConnection: UILabel!
    
    var userOfZone: UserOfZoneViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.layer.cornerRadius = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
    }

    func configureUI() {
        labelUser.text = userOfZone.name
        labelLastConnection.text = userOfZone.fecha + "  " + userOfZone.hora
    }
    
}
