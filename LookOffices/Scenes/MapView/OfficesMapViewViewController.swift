//
//  OfficesMapViewViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 19.08.2022.
//

import UIKit
import MapKit
import CoreLocation

protocol OfficesMapViewDisplayLogic: AnyObject {
    func getOfficeMapInfo(response : OfficesMapView.Fetch.ViewModel)
    func showAlert(AlertMessage : String)
}

final class OfficesMapViewViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var interactor: OfficesMapViewBusinessLogic?
    var router: (OfficesMapViewRoutingLogic & OfficesMapViewDataPassing)?
    var mapindex = 0
    var locationManager = CLLocationManager()
    
    
    var officesMap : [OfficesMapView.Fetch.ViewModel.OfficeMapInfo] = []
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getOfficeMapInfo()
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficesMapViewInteractor()
        let presenter = OfficesMapViewPresenter()
        let router = OfficesMapViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension OfficesMapViewViewController: OfficesMapViewDisplayLogic {
    func showAlert(AlertMessage: String) {
        func showAlert(AlertMessage: String) {
            let alert = AppConstants.alertError(Error: AlertMessage)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    }
    
    func getOfficeMapInfo(response: OfficesMapView.Fetch.ViewModel)
    {
        officesMap = response.officesMapInfo
        for item in officesMap
        {
            let annotation = OfficeAnnotation(coordinate: .init(latitude: item.latitude, longitude: item.longidute), title: item.name, id: item.id)
            mapView.addAnnotation(annotation)
        }
    }
}

extension OfficesMapViewViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation
        {
            return nil
        }

         let reuseId = "CustomOfficesPinView"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil
        {
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            pinView?.canShowCallout=true
            
            let infoButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
            infoButton.tag = 1
            let detailButton = UIButton()
            detailButton.setImage(UIImage.navigasyonButtonImage, for: .normal)
            detailButton.frame = infoButton.frame
            pinView?.rightCalloutAccessoryView = detailButton
            pinView?.leftCalloutAccessoryView = infoButton
        }
        else
        {
            pinView?.annotation = annotation
        }
        pinView?.image = UIImage.pinImage
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // butonlardan hangisini tıklandığını anlıyıp ona göre navigasyona yada office detay sayfasına yönlendirme yapıyorum
        guard  let selectedAnnotation = view.annotation else { return }
        if control.tag == 0
        {
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

        else
        {
            guard let selectedAnnotationId  = view.annotation as? OfficeAnnotation else { return }
            router?.routerToDetailOffice(officeId: selectedAnnotationId.id)
        }
    }
}

extension OfficesMapViewViewController : CLLocationManagerDelegate {
    // MARK: belirli bir lokasyona zoom yaparak açıyorum haritayı
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Kullanıcının lokasyonuna  zoom yaparak açıyorum haritayı
        //let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        // İstanbul beşiktaşa coordinatları
        let locationDefault = CLLocationCoordinate2D(latitude: 41.03959942370373, longitude: 28.99901055767461)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: locationDefault, span: span)
        mapView.setRegion(region, animated: true)
    }
}
