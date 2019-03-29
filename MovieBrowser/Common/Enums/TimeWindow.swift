//
//  TimeWindow.swift
//  MovieBrowser
//
//  Created by UHP Mac on 26/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import Foundation

enum TimeWindow: String {
    case day = "day"
    case week = "week"
    
    static var allValues: [TimeWindow] {
        return [.week, .day]
    }
}
