//
//  AppConstants.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation
import UIKit

struct AppConstants {
   static let firebaseURL =  "https://officer-ad6ef-default-rtdb.firebaseio.com/offices.json"
    static let notFoundURL =  "Bağlantı hatası. Lütfen daha sonra tekrar deneyin."
    static let notConnet =  "Lütfen internet bağlantınızı kontrol edip tekrar deneyin."
    static let error = "Servis bağlantısı kurulamadı. Lütfen daha sonra tekrar deneyin."
    static let filterDefaultText = "Lütfen bir değer giriniz."
    static let errorNotFoundOfficeId = "Unique Key İd Not Found"
    static let errorNilOfficeId = "Nil OfficeId"
    static let notFoundImage = "https://e7.pngegg.com/pngimages/829/733/png-clipart-logo-brand-product-trademark-font-not-found-logo-brand.png"
    static let kSecAttrAccount = "samet"
    static let kSecAttrServer = "mainServer"
    static let kSecAttrPath = "com.samet"
    
    static func alertError(Error: String) -> UIAlertController {
    let alert = UIAlertController(title: "Error", message: Error, preferredStyle: UIAlertController.Style.alert)
    return alert
    }
}
