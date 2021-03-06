//
//  TrendingVC.swift
//  MovieBrowser
//
//  Created by UHP Mac on 28/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit
import RxDataSources

class TrendingVC: BaseViewController<TrendingVM> {
    
    @IBOutlet weak var tfMediaType: UITextField!
    @IBOutlet weak var tfTimeWindow: UITextField!
    @IBOutlet weak var cvMovies: UICollectionView!
    @IBOutlet weak var cvShows: UICollectionView!
    
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

    private var movieDataSource: RxCollectionViewSectionedAnimatedDataSource<MovieSection>? = nil
    private var showDataSource: RxCollectionViewSectionedAnimatedDataSource<ShowSection>? = nil
    
    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }
    
    func setup() {
        title = "Trending"
//        navigationController?.setNavigationBarHidden(true, animated: false)
        timePickerView = createPickerView()
        typePickerView = createPickerView()
        setupPickers()
        
        tfMediaType.delegate = self
        tfTimeWindow.delegate = self
        
        navigationController?.navigationBar.barStyle = .black
        
        setupCollectionViews()
    }
    
    override func bindToViewModel() {
        let mediaTypeTrigger = tfMediaType.rx.text
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
        
        let movieTrigger = mediaTypeTrigger
            .filter { $0 == MediaType.movie.rawValue }
            .mapToVoid()
        let showTrigger = mediaTypeTrigger
            .filter { $0 == MediaType.tv.rawValue }
            .mapToVoid()
        
        let timeTrigger = tfTimeWindow.rx.text
            .asDriver()
            .map { _ in self.selectedTimeWindow }
        
        let movieSelected = cvMovies.rx.modelSelected(Movie.self).asDriver()
        let showSelected = cvShows.rx.modelSelected(Show.self).asDriver()
        
        let input = TrendingVM.Input(
            movieUpdateTrigger: movieTrigger,
            showUpdateTrigger: showTrigger,
            timeWindow: timeTrigger,
            movieSelectedTrigger: movieSelected,
            showSelectedTrigger: showSelected
        )
        
        let output = viewModel.transform(input: input)
        
        output.trendingMovies
            .drive(cvMovies.rx.items(dataSource: movieDataSource!))
            .disposed(by: disposeBag)
        
        output.trendingShows
            .drive(cvShows.rx.items(dataSource: showDataSource!))
            .disposed(by: disposeBag)
        
        output.navigateToDetailsEvent
            .drive(onNext: { [weak self] in
                self?.navigate(to: .details(mediaId: $0.mediaId, mediaType: $0.type))
            }).disposed(by: disposeBag)
    }
    
    private func handleTableViewVisibility(_ mediaType: String?) {
        if let type = mediaType {
            cvMovies.isHidden = type != MediaType.movie.rawValue
            cvShows.isHidden = type == MediaType.movie.rawValue
        }
    }
    
}

extension TrendingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    private func createPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        pickerView.tintColor = Colors.primary
        return pickerView
    }
    
    private func setupPickers() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.black
        toolBar.isTranslucent = true
        toolBar.tintColor = Colors.primary
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pickerCancel))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(pickerDone))
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
        
        if tfTimeWindow.text != selectedTimeWindow.rawValue || tfMediaType.text != selectedMediaType.rawValue {
            if cvMovies.isHidden {
                cvShows.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            } else {
                cvMovies.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
        
        tfMediaType.text = selectedMediaType.rawValue
        tfTimeWindow.text = selectedTimeWindow.rawValue
        handleTableViewVisibility(selectedMediaType.rawValue)
        
        view.endEditing(true)
    }
    
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

extension TrendingVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func setupCollectionViews() {
        cvMovies.registerCell(cellType: MediaCell.self)
        cvMovies.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        cvShows.registerCell(cellType: MediaCell.self)
        cvShows.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        movieDataSource = RxCollectionViewSectionedAnimatedDataSource<MovieSection> (
            configureCell: { _, cv, ip, movie in
                let cell = cv.dequeueReusableCell(cellType: MediaCell.self, for: ip)!
                cell.setup(with: movie)
                return cell
            }
        )
        
        showDataSource = RxCollectionViewSectionedAnimatedDataSource<ShowSection> (
            configureCell: { _, cv, ip, show in
                let cell = cv.dequeueReusableCell(cellType: MediaCell.self, for: ip)!
                cell.setup(with: show)
                return cell
            }
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvMovies {
            
            
        } else {
            
        }
    }
    
}
