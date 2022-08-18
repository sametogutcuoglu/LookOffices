//
//  OfficeCell.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import UIKit
import SDWebImage
import CoreData

protocol ClickLikeDelegate: AnyObject {
    func clickLike(officeId : Int,officeName : String,officeImage : UIImage,officeRoom: Int,
                   officeCapacity: String,officeSpace:String)
}
protocol ClickDisLikeDelegate: AnyObject {
    func clickDisLike(officeId : Int)
}

class OfficeCell: UITableViewCell {
    
    static let identifier = "OfficeCell"
    @IBOutlet weak var officeNameLabel: UILabel!
    @IBOutlet weak var officeRoomLabel: UILabel!
    @IBOutlet weak var officeCapacityLabel: UILabel!
    @IBOutlet weak var officeSpaceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet var officeImageView: UIImageView!
    var liked : Bool = true
    var officeId : Int?
    weak var likeButtonDelegate : ClickLikeDelegate?
    weak var disLikeButtonDelegate : ClickDisLikeDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        officeImageView.layer.cornerRadius = 10
    }
    
    @IBAction func clickLikeButton(_ sender: Any) {

        guard let button = sender as? UIButton else { return }
        guard let officeId = officeId else {
            return
        }
        if (liked) {
            guard let room = Int(officeRoomLabel.text ?? "") else { return }
            likeButtonDelegate?.clickLike(officeId: officeId,officeName : officeNameLabel.text ?? "",officeImage : officeImageView.image ?? UIImage.notFoundImage,officeRoom: room,
                officeCapacity: officeCapacityLabel.text ?? "",officeSpace: officeSpaceLabel.text ?? "")
            button.setImage(UIImage.like, for: .normal)
            liked = false
        }
        else {
            disLikeButtonDelegate?.clickDisLike(officeId: officeId)
            button.setImage(UIImage.dislike, for: .normal)
            liked = true
        }
    }
    
    func configure(viewModel: ListOffices.FetchOffices.ViewModel.Office) {
        officeId = viewModel.id
        officeImageView.sd_setImage(with: URL(string: viewModel.image))
        officeNameLabel.text = viewModel.name
        officeRoomLabel.text = "\(viewModel.rooms)"
        officeCapacityLabel.text = viewModel.capacity
        officeSpaceLabel.text = viewModel.space
    }
    
    func configure(image: UIImage, Name: String, officeRoom: Int,officeCapacity : String ,
                   officeSpace : String,officeId: Int) {
        self.officeId = officeId
        officeNameLabel.text = Name
        officeImageView.image = image
        officeRoomLabel.text = "\(officeRoom)"
        officeSpaceLabel.text = officeSpace
        officeCapacityLabel.text = officeCapacity
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
            else { return }
            self.layer.borderColor = UIColor.loginTopViewBackgroundColor.cgColor
        }
    }
    
}
