//
//  FilterViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 12.08.2022.
//

import UIKit
import IQKeyboardManagerSwift

protocol FilterDisplayLogic: AnyObject {
    func distinctFilterData(capacity: [String],room:[Int],space:[String])
    func FilterOfficesData(viewModel: ListOffices.FetchOffices.ViewModel,chooseImage:Bool)
    func responseFilterData(capacity:String,room:String,space:String)
}

protocol FilterDataPass : AnyObject{
    func responseFilterData(viewModel: ListOffices.FetchOffices.ViewModel, changeImage:Bool)
}

final class FilterViewController: UIViewController {
    let defualts = UserDefaults.standard
    var changeImage : Bool = false
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    
    @IBOutlet weak var capacityTextFiled: UITextField!
    @IBOutlet weak var roomTextFiled: UITextField!
    @IBOutlet weak var spaceTextFiled: UITextField!

    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var roomView: UIView!
    @IBOutlet weak var capacityView: UIView!
    
    weak var interactor: FilterBusinessLogic?
    var router: (FilterRoutingLogic & FilterDataPassing)?
    
    var filterDataDelegate : FilterDataPass?
    
    var listOfficeData: [ListOffices.FetchOffices.ViewModel.Office] = []
    
    private var capacityPickerView = UIPickerView()
    private var roomPickerView = UIPickerView()
    private var spacePickerView = UIPickerView()
    
    private var distinctCapacity  = [String()]
    private var distinctroom  = [Int()]
    private var distinctspace = [String()]
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.topItem?.title = "Filtre"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:
                                                                    UIFont.systemFont(ofSize:24, weight: .bold)]
        capacityView.addBorder()
        roomView.addBorder()
        spaceView.addBorder()
        
        interactor?.getDistinctFilterData()
        
        setupTextfiled()
        defualts.register(
            defaults: [
                "capacity": AppConstants.filterDefaultText,
                "room": AppConstants.filterDefaultText,
                "space":  AppConstants.filterDefaultText
            ])
        labelTextControl()
        
        capacityPickerView.tag = 1
        roomPickerView.tag = 2
        spacePickerView.tag = 3
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Bitti"
        
        capacityPickerView.delegate = self
        capacityPickerView.dataSource = self
        roomPickerView.delegate = self
        roomPickerView.dataSource = self
        spacePickerView.delegate = self
        spacePickerView.dataSource = self
    }
    
    private func setupTextfiled() {
        capacityTextFiled.tintColor = UIColor.clear
        roomTextFiled.tintColor = UIColor.clear
        spaceTextFiled.tintColor = UIColor.clear
        
        capacityTextFiled.inputView = capacityPickerView
        roomTextFiled.inputView = roomPickerView
        spaceTextFiled.inputView = spacePickerView
        capacityTextFiled.tag = 1
        roomTextFiled.tag = 2
        spaceTextFiled.tag = 3
        
        capacityTextFiled.addTarget(self, action: #selector(clickTextField), for: .touchDown)
        roomTextFiled.addTarget(self, action: #selector(clickTextField), for: .touchDown)
        spaceTextFiled.addTarget(self, action: #selector(clickTextField), for: .touchDown)
    }
    
    @objc func clickTextField(textField: UITextField) {
        switch textField.tag {
        case 1:
            
            capacityView.layer.borderColor = UIColor.filtreViewBorderColor.cgColor
            roomView.layer.borderColor = UIColor.lightGray.cgColor
            spaceView.layer.borderColor = UIColor.lightGray.cgColor
        case 2:
            roomView.layer.borderColor = UIColor.filtreViewBorderColor.cgColor
            capacityView.layer.borderColor = UIColor.lightGray.cgColor
            spaceView.layer.borderColor = UIColor.lightGray.cgColor
        case 3:
            spaceView.layer.borderColor = UIColor.filtreViewBorderColor.cgColor
            capacityView.layer.borderColor = UIColor.lightGray.cgColor
            roomView.layer.borderColor = UIColor.lightGray.cgColor
        default:
            return
        }
    }
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FilterInteractor()
        let presenter = FilterPresenter()
        let router = FilterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @IBAction func clickFilterButton(_ sender: Any) {
        defualts.set(capacityLabel.text, forKey: "capacity")
        defualts.set(roomLabel.text, forKey: "room")
        defualts.set(spaceLabel.text, forKey: "space")
        labelTextControl()
        guard let capacity = capacityLabel.text else { return }
        guard let room = roomLabel.text else { return }
        guard let space = spaceLabel.text else { return }
        
        interactor?.responseFilterData(capacity: capacity, room: room, space: space)
        
        filterDataDelegate?.responseFilterData(viewModel: ListOffices.FetchOffices.ViewModel(Offices: listOfficeData),changeImage:changeImage)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickAllClearButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "capacity")
        UserDefaults.standard.removeObject(forKey: "room")
        UserDefaults.standard.removeObject(forKey: "space")
        labelTextControl()
        guard let capacity = capacityLabel.text else { return }
        guard let room = roomLabel.text else { return }
        guard let space = spaceLabel.text else { return }

        interactor?.responseFilterData(capacity: capacity, room: room, space: space)
        
        filterDataDelegate?.responseFilterData(viewModel: ListOffices.FetchOffices.ViewModel(Offices: listOfficeData),changeImage:changeImage)

        self.navigationController?.popViewController(animated: true)
    }
    
    private func labelTextControl() {
        capacityLabel.text = defualts.string(forKey: "capacity")
        spaceLabel.text = defualts.string(forKey: "space")
        roomLabel.text = defualts.string(forKey: "room")
    }
}

extension FilterViewController: FilterDisplayLogic {
    
    func FilterOfficesData(viewModel: ListOffices.FetchOffices.ViewModel,chooseImage:Bool) {
        listOfficeData = viewModel.Offices
        changeImage = chooseImage
    }
    
    func distinctFilterData(capacity: [String],room:[Int],space:[String]) {
        distinctCapacity = capacity
        distinctroom = room
        distinctspace = space
    }
    
    func responseFilterData(capacity: String, room: String, space: String) {
        interactor?.responseFilterData(capacity: capacity, room: room, space: space)
    }
}
extension FilterViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:
            return distinctCapacity.count
        case 2:
            return distinctroom.count
        case 3:
            return distinctspace.count
        default:
            return .zero
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 1:
            capacityLabel.text = distinctCapacity[row]
            return distinctCapacity[row]
            
        case 2:
            roomLabel.text = "\(distinctroom[row])"
            return String(distinctroom[row])
        case 3:
            spaceLabel.text = distinctspace[row]
            return distinctspace[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch pickerView.tag {
        case 1:
            capacityLabel.text = distinctCapacity[row]
        case 2:
            roomLabel.text = "\(distinctroom[row])"
        case 3:
            spaceLabel.text = distinctspace[row]
        default: break
        }
    }
}
