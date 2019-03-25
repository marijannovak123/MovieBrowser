//
//  MovieSlide.swift
//  MovieBrowser
//
//  Created by UHP Mac on 22/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit
import Kingfisher

class MovieSlide: UIView {

    @IBOutlet weak var lTitle: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    
    static func create(title: String, posterURL: String) -> MovieSlide {
        let slide = Bundle.main.loadNibNamed("MovieSlide", owner: self, options: nil)?.first as! MovieSlide
        slide.lTitle.text = title
        slide.ivPoster.kf.setImage(with: URL(string: posterURL))
        return slide
    }
}
