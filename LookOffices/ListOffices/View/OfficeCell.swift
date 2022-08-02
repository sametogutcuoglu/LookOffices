//
//  OfficeCell.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import UIKit
import SDWebImage

class OfficeCell: UITableViewCell {

    @IBOutlet weak var spaces: UILabel!
    @IBOutlet weak var rooms: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var officeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configure(viewModel : ListOffices.FetchOffices.ViewModel.DisplayedOffice) {
        officeImageView.sd_setImage(with: URL(string: viewModel.image ?? ""))
        rooms.text = "\(viewModel.rooms ?? .zero)"
        adress.text = viewModel.address
        spaces.text = viewModel.space
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
