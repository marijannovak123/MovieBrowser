//
//  DetailsVM.swift
//  MovieBrowser
//
//  Created by UHP Mac on 03/04/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

class DetailsVM: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private let repository: MediaRepository
    
    init(repository: MediaRepository) {
        self.repository = repository
    }
    
    func transform(input: DetailsVM.Input) -> DetailsVM.Output {
        return Output()
    }
}
