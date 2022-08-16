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
    
    func configureData(Model:OfficeDetail.FetchOfficeDetail.ViewModel.OfficeDetail) {
        kapasite.text = Model.capacity
        alan.text = Model.space
        odaSayisi.text = "\(Model.rooms)"
        adres.text = Model.address
    }
}
