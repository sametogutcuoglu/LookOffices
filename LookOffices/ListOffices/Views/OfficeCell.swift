//
//  OfficeCell.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import SDWebImage
import UIKit

final class OfficeCell: UITableViewCell {
    @IBOutlet var spaces: UILabel!
    @IBOutlet var rooms: UILabel!
    @IBOutlet var adress: UILabel!
    @IBOutlet var officeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(viewModel: ListOffices.FetchOffices.ViewModel.Office) {
        officeImageView.sd_setImage(with: URL(string: viewModel.image ?? ""))
        rooms.text = "\(viewModel.rooms ?? .zero)"
        adress.text = viewModel.address
        spaces.text = viewModel.space
    }
}
