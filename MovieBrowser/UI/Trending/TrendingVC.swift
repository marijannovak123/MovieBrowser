//
//  TrendingVC.swift
//  MovieBrowser
//
//  Created by UHP Mac on 28/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit

class TrendingVC: BaseViewController<TrendingVM> {
    
    @IBOutlet weak var tfMediaType: UITextField!
    @IBOutlet weak var tfTimeWindow: UITextField!
    
    private var typePickerView: UIPickerView!
    private var timePickerView: UIPickerView!
    
    private var selectedMediaType: MediaType {
        let index = typePickerView.selectedRow(inComponent: 0)
        return MediaType.trendingTypes[index]
    }
    
    private var selectedTimeWindow: TimeWindow {
        let index = timePickerView.selectedRow(inComponent: 0)
        return TimeWindow.allValues[index]
    }
    
    override func viewDidLoad() {
        title = "Trending"
        timePickerView = createPickerView()
        typePickerView = createPickerView()
        setupPicker(picker: typePickerView)
        setupPicker(picker: timePickerView)
        tfMediaType.delegate = self
        tfTimeWindow.delegate = self
        
        super.viewDidLoad()
     
        tfMediaType.text = selectedMediaType.rawValue
        tfTimeWindow.text = selectedTimeWindow.rawValue
    }
    
    override func bindToViewModel() {
        let mediaTypeTrigger = tfMediaType.rx.text
            .asDriver()
            .do(onNext: handleTableViewVisibility)
            .mapToVoid()
        
        let movieTrigger = mediaTypeTrigger.filter { _ in self.selectedMediaType == .movie }
        let showTrigger = mediaTypeTrigger.filter { _ in self.selectedMediaType == .tv }
        
        let timeTrigger = tfTimeWindow.rx.text
            .asDriver()
            .map { _ in self.selectedTimeWindow }
        
        let input = TrendingVM.Input(
            movieUpdateTrigger: movieTrigger,
            showUpdateTrigger: showTrigger,
            timeWindow: timeTrigger
        )
        
        let output = viewModel.transform(input: input)
        
        output.trendingMovies.drive(onNext: { print($0) }).disposed(by: disposeBag)
        output.trendingShows.drive(onNext: { print($0) }).disposed(by: disposeBag)
    }
    
    private func createPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        return pickerView
    }
    
    private func setupPicker(picker: UIPickerView) {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = Colors.primary
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pickerCancel))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pickerDone))
        toolBar.isUserInteractionEnabled = true
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        tfMediaType.inputView = typePickerView
        tfMediaType.inputAccessoryView = toolBar
        tfMediaType.tintColor = UIColor.clear
        tfTimeWindow.inputView = timePickerView
        tfTimeWindow.inputAccessoryView = toolBar
        tfTimeWindow.tintColor = UIColor.clear
    }
    
    @objc func pickerCancel() {
        view.endEditing(true)
    }
    
    @objc func pickerDone() {
        view.endEditing(true)
        tfMediaType.text = selectedMediaType.rawValue
        tfTimeWindow.text = selectedTimeWindow.rawValue
    }
    
    private func handleTableViewVisibility(_ mediaType: String?) {
        if let type = mediaType {
//            tvMovies.isHidden = type != MediaType.movie.rawValue
//            tvShows.isHidden = type == MediaType.movie.rawValue
        }
    }
    
}

extension TrendingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case timePickerView:
            return TimeWindow.allValues.count
        case typePickerView:
            return MediaType.trendingTypes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case timePickerView:
            return TimeWindow.allValues[row].rawValue
        case typePickerView:
            return MediaType.trendingTypes[row].rawValue
        default:
            return ""
        }
    }
    
}

extension TrendingVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
}
