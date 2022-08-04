//
//  OfficeCell.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import UIKit
import SDWebImage

class OfficeCell: UITableViewCell {
    
    @IBOutlet weak var officeName: UILabel!
    @IBOutlet var officeImageView: UIImageView!
    var liked : Bool = true

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickLikeButton(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        if (liked) {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            liked = false
        }
        else {
            button.setImage(UIImage(named: "heart"), for: .normal)
            liked = true
        }

    }
    func configure(viewModel: ListOffices.FetchOffices.ViewModel.Office) {
        officeImageView.layer.cornerRadius = 10
        officeImageView.sd_setImage(with: URL(string: viewModel.image ?? ""))
        officeName.text = viewModel.name
    }
    
}
