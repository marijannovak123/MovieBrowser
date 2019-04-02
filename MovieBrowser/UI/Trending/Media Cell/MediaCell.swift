//
//  MediaCell.swift
//  MovieBrowser
//
//  Created by UHP Mac on 02/04/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit
import Kingfisher

class MediaCell: UICollectionViewCell, ReusableCell {

    typealias Data = Movie
    
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lTitle: UILabel!
    @IBOutlet weak var lPopularity: UILabel!
    @IBOutlet weak var lViews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configure(with data: Movie) {}
    
    func setup(with movie: Movie) {
        lTitle.text = movie.title ?? movie.originalTitle
        lPopularity.text = String(movie.voteAverage ?? 0.0)
        lViews.text = String(movie.voteCount ?? 0)
        
        ivPoster.setPosterImage(path: movie.posterPath)
    }
    
    func setup(with show: Show) {
        lTitle.text = show.name ?? show.originalName
        lPopularity.text = String(show.voteAverage ?? 0.0)
        lViews.text = String(show.voteCount ?? 0)
        
        ivPoster.setPosterImage(path: show.posterPath)
    }
    

}
