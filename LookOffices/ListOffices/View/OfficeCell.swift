//
//  OfficeCell.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import UIKit

class OfficeCell: UITableViewCell {

    @IBOutlet weak var spaces: UILabel!
    @IBOutlet weak var rooms: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(viewModel : ListOffices.FetchOffices.ViewModel.DisplayedOffice) {
        print(viewModel.image)
        guard let url = URL(string: viewModel.image ?? "") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) {[weak self] data,_,_ in
            if let data = data {
                self?.ImageView.image = UIImage(data: data)
            }
            
        }
        //guard let rooms = viewModel.rooms as? String else { return }
        let room = viewModel.rooms
        if let rooms = room as? String {
            self.rooms.text = rooms
        }
        else {
            self.rooms.text = "0"
        }
        adress.text = viewModel.address
        spaces.text = viewModel.space
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
