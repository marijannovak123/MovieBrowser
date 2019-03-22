//
//  SwipeVC.swift
//  MovieBrowser
//
//  Created by UHP Mac on 22/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import UIKit

class SwipeVC: UIViewController {
    
    @IBOutlet weak var svMoviePosters: UIScrollView! {
        didSet {
            svMoviePosters.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    private lazy var slides: [MovieSlide] = createSlides()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScrollView(size: view.bounds.size)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupScrollView(size: CGSize) {
        svMoviePosters.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        svMoviePosters.contentSize = CGSize(width: size.width * CGFloat(slides.count), height: size.height)
        svMoviePosters.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: size.width * CGFloat(i), y: 0, width: size.width, height: size.height)
            svMoviePosters.addSubview(slides[i])
        }
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    private func createSlides() -> [MovieSlide] {
        return [
            MovieSlide.create(title: "Avengers: Endgame", posterURL: "https://images-na.ssl-images-amazon.com/images/I/A1t8xCe9jwL._SY679_.jpg"),
            MovieSlide.create(title: "Deadpool 2", posterURL: "https://images-na.ssl-images-amazon.com/images/I/71yJRbLpSeL._SY606_.jpg")
        ]
    }
}

extension SwipeVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(svMoviePosters.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(page)
    }
    
}
