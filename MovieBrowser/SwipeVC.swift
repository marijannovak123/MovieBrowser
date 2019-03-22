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
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
            
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
