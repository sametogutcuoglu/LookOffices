//
//  OfficeDetailCell.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 4.08.2022.
//

import UIKit

class OfficeDetailCell: UICollectionViewCell {

    @IBOutlet weak var officeImagesView: UIImageView!
    static let identifier = "OfficeDetailCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        officeImagesView.layer.cornerRadius = 10
    }
    
    func configure (image : String?) {
        guard let url = URL(string: image ?? "") else  { return }
            officeImagesView.sd_setImage(with: url)
    }
}
