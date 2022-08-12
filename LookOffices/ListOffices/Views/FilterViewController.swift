//
//  FilterViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 11.08.2022.
//

import UIKit
import IQKeyboardManagerSwift

protocol FilterDataPass {
    func responseData(viewModel: ListOffices.FetchOffices.ViewModel)
}

class FilterViewController: UIViewController {
    
    var filterDataDelegate : FilterDataPass?
    
    var filterData: [ListOffices.FetchOffices.ViewModel.Office] = []
    
    @IBOutlet weak var capacity : UITextField!
    @IBOutlet weak var room : UITextField!
    @IBOutlet weak var space : UITextField!
    private var capacityPickerView = UIPickerView()
    private var roomPickerView = UIPickerView()
    private var spacePickerView = UIPickerView()
    var capacityArray  = [
        "0-5","0-10","10-20","10-25"]
    
    var roomArray  = [
        5,10,30,8]
    var spaceArray = [
        "100m2","200m2","120m2","200m2","220m2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capacity.inputView = capacityPickerView
        room.inputView = roomPickerView
        space.inputView = spacePickerView
        
        capacityPickerView.dataSource = self
        capacityPickerView.delegate = self
        roomPickerView.dataSource = self
        roomPickerView.delegate = self
        spacePickerView.dataSource = self
        spacePickerView.delegate = self
        
        capacityPickerView.tag = 1
        roomPickerView.tag = 2
        spacePickerView.tag = 3
    }
    @IBAction func clickButton(_ sender: Any) {
        let capacity = capacity.text!
        let room = room.text!
        let space = space.text!
        fetchFilterData(capacity: capacity, room: room, space: space)
        filterDataDelegate?.responseData(viewModel:ListOffices.FetchOffices.ViewModel(Offices: filterData) )
        //dismiss(animated: true)
    }
    
    private func fetchFilterData(capacity: String,room:String,space:String) {
        // TODO: kontroller yap ve varsa array filtrele yoksa mevcut etteriyi döndür sonraki if blogouna gitsin
        if  capacity.isEmpty {
            
        }
        else {
            print(capacity)
            
            filterData = filterData.filter({$0.capacity!.contains(capacity)})
        }
        if room.isEmpty {
            
        }
        else {
            filterData = filterData.filter({$0.rooms!.isMultiple(of: Int(room)!) })
            print(room)
        }
        if space.isEmpty {
            
        }
        else {
            filterData = filterData.filter({$0.space!.contains(space) })
            print(space)
        }
        
        print(filterData)
        
       
    }
}

extension FilterViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:
            return capacityArray.count
        case 2:
            return roomArray.count
        case 3:
            return spaceArray.count
        default:
            return .zero
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 1:
            return capacityArray[row]
        case 2:
            return String(roomArray[row])
        case 3:
            return spaceArray[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch pickerView.tag {
        case 1:
            capacity.text = capacityArray[row]
        case 2:
            room.text = "\(roomArray[row])"
        case 3:
            space.text = spaceArray[row]
        default: break
        }
        
    }
}
