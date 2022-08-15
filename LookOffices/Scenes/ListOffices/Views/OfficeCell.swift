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
    func clickLike(officeId : Int,officeName : String,officeImage : UIImage)
    func clickDisLike(officeId : Int)
}

class OfficeCell: UITableViewCell {
    
    static let identifier = "OfficeCell"
    @IBOutlet weak var officeName: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet var officeImageView: UIImageView!
    var liked : Bool = true
    var officeId : Int?
    weak var likeButtonDelegate : ClickLikeDelegate?
    weak var disLikeButtonDelegate : ClickLikeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func getButtonImage(like: Bool) {
        if like {
            likeButton.setImage(UIImage.like, for: .normal)
        }
        else {
            likeButton.setImage(UIImage.dislike, for: .normal)
        }
    }
    @IBAction func clickLikeButton(_ sender: Any) {

        guard let button = sender as? UIButton else { return }
        guard let officeId = officeId else {
            return
        }
        if (liked) {
            likeButtonDelegate?.clickLike(officeId: officeId,officeName : officeName.text!,officeImage : officeImageView.image!)
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
        officeImageView.layer.cornerRadius = 10
        officeImageView.sd_setImage(with: URL(string: viewModel.image))
        officeName.text = viewModel.name
    }
    
    func configure(image: UIImage, Name: String, officeId: Int) {
        self.officeId = officeId
        officeName.text = Name
        officeImageView.image = image
    }
    
}
