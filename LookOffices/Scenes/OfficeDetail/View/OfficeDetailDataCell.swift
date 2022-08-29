//
//  OfficeDetailDataCell.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 5.08.2022.
//

import UIKit
import MapKit

protocol clickWebSiteOpenClickDelegate : AnyObject {
    func buttonClick()
}

protocol clickVideoPlayButtonDelegate : AnyObject {
    func playButtonClick()
}

class OfficeDetailDataCell: UICollectionViewCell {
    static let identifier = "OfficeDetailDataCell"
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var odaSayisi: UILabel!
    @IBOutlet weak var kapasite: UILabel!
    @IBOutlet weak var alan: UILabel!
    @IBOutlet weak var officeName: UILabel!
    @IBOutlet weak var adres: UILabel!
    var officeLatitude : Double?
    var officeLongitude : Double?
    var locationManager = CLLocationManager()
    weak var clickWebSiteDelegate : clickWebSiteOpenClickDelegate?
    weak var clickVideoPlayButtonDelegate: clickVideoPlayButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func configureData(Model:OfficeDetail.FetchOfficeDetail.ViewModel.OfficeDetail) {
        kapasite.text = Model.capacity
        alan.text = Model.space
        odaSayisi.text = "\(Model.rooms)"
        officeName.text = Model.name
        adres.text = Model.address
        officeLatitude = Model.latitude
        officeLongitude = Model.longidute
        let annotation = OfficeAnnotation(coordinate: .init(latitude: Model.latitude, longitude: Model.longidute), title: Model.name, id: Model.id)
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func clickWebSiteOpenButton( sender: Any) {
        clickWebSiteDelegate?.buttonClick()
    }
    
    @IBAction func clickVidepPlayButton( sender: Any) {
        clickVideoPlayButtonDelegate?.playButtonClick()
    }
}

extension OfficeDetailDataCell : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

         let reuseId = "CustomOfficePinView"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil
        {
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            pinView?.canShowCallout=true
            
            let navigasyonButton = UIButton(type: UIButton.ButtonType.detailDisclosure)

            navigasyonButton.frame = pinView?.frame ?? CGRect(x: 0, y: 0, width: 26, height: 26)
            pinView?.rightCalloutAccessoryView = navigasyonButton
        }
        else
        {
            pinView?.annotation = annotation
        }
        return pinView
    }
 // MARK: Navigasyon
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        guard  let selectedAnnotation = view.annotation else { return }

            let requestLocation = CLLocation(latitude: selectedAnnotation.coordinate.latitude,
                                             longitude: selectedAnnotation.coordinate.longitude)

                CLGeocoder().reverseGeocodeLocation(requestLocation)
            { (placemark , Error) in

                    if let placemarks = placemark
                    {
                            let newPlacemark = MKPlacemark(placemark: placemarks[0])

                            let item = MKMapItem(placemark: newPlacemark)

                            item.name = selectedAnnotation.title ?? "Not Found Offices"

                            let launchOption = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]

                            item.openInMaps(launchOptions: launchOption)
                    }
            }

    }
}

extension OfficeDetailDataCell : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let officelocation = CLLocationCoordinate2D(latitude: officeLatitude ?? .zero, longitude: officeLongitude ?? .zero)
        let span = MKCoordinateSpan(latitudeDelta: 00.1, longitudeDelta: 00.1)
        let region = MKCoordinateRegion(center: officelocation, span: span)
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
}
