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
}
protocol ClickDisLikeDelegate: AnyObject {
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
            likeButtonDelegate?.clickLike(officeId: officeId,officeName : officeName.text ?? "",officeImage : officeImageView.image ?? UIImage())
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
        officeName.text = viewModel.name
    }
    
    func configure(image: UIImage, Name: String, officeId: Int) {
        self.officeId = officeId
        officeName.text = Name
        officeImageView.image = image
    }
    
}
