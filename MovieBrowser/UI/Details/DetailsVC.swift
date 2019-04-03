//
//  DetailsVC.swift
//  MovieBrowser
//
//  Created by UHP Mac on 03/04/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit

class DetailsVC: BaseViewController<DetailsVM> {

    var movieId: Int = -1
    var mediaType: MediaType = .movie
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindToViewModel() {
        
    }

}
