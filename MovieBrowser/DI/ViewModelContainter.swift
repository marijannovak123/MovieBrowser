//
//  ViewModelContainter.swift
//  MovieBrowser
//
//  Created by Marijan on 23/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Swinject

class ViewModelContainer {
    
    static func build(singletonContainer: Container) -> Container {
        let container = Container(parent: singletonContainer)
        
        return container
    }
}
