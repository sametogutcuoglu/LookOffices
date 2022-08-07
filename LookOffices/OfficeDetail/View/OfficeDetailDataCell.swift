//
//  OfficeDetailDataCell.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 5.08.2022.
//

import UIKit

class OfficeDetailDataCell: UICollectionViewCell {
    static let identifier = "OfficeDetailDataCell"

    @IBOutlet weak var odaSayisi: UILabel!
    @IBOutlet weak var kapasite: UILabel!
    @IBOutlet weak var alan: UILabel!
    @IBOutlet weak var adres: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureData(Model:OfficeDetail.FetchOfficeDetail.Response) {
        kapasite.text = Model.office?.capacity
        alan.text = Model.office?.space
        odaSayisi.text = "\(Model.office?.rooms ?? .zero)"
        adres.text = Model.office?.address
        
    }

}
