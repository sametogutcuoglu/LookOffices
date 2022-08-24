//
//  OfficeDetailCell.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 4.08.2022.
//

import UIKit

protocol FullScreenImageShowDelegate : AnyObject {
    func showFullScreenImage()
}

class OfficeDetailCell: UICollectionViewCell {

    @IBOutlet weak var officeImagesView: UIImageView!
    static let identifier = "OfficeDetailCell"
    weak var fullScreenImageDelegate : FullScreenImageShowDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        officeImagesView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        officeImagesView.addGestureRecognizer(gestureRecognizer)
    }
    
    func configure (image : String?) {
        officeImagesView.layer.cornerRadius = 10
        guard let url = URL(string: image ?? AppConstants.notFoundImage) else  { return }
            officeImagesView.sd_setImage(with: url)
    }
    
    @objc func changePic(sender : UITapGestureRecognizer) {
        fullScreenImageDelegate?.showFullScreenImage()
    }
}
