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
    
    func configure (image : String?) {
        officeImagesView.layer.cornerRadius = 10
        guard let url = URL(string: image ?? AppConstants.notFoundImage) else  { return }
            officeImagesView.sd_setImage(with: url)
    }
}
