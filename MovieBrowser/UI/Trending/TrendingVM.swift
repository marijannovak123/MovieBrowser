//
//  TrendingVM.swift
//  MovieBrowser
//
//  Created by UHP Mac on 29/03/2019.
//  Copyright © 2019 Novak. All rights reserved.
//

import RxSwift
import RxCocoa

typealias SelectedItem = (mediaId: Int, type: MediaType)

class TrendingVM: ViewModelType {
    
    struct Input {
        let movieUpdateTrigger: Driver<Void>
        let showUpdateTrigger: Driver<Void>
        let timeWindow: Driver<TimeWindow>
        let movieSelectedTrigger: Driver<Movie>
        let showSelectedTrigger: Driver<Show>
    }
    
    struct Output {
        let trendingMovies: Driver<[MovieSection]>
        let trendingShows: Driver<[ShowSection]>
        let navigateToDetailsEvent: Driver<SelectedItem>
    }
    
    private let repository: MediaRepository
    
    init(repository: MediaRepository) {
        self.repository = repository
    }
    
    func transform(input: TrendingVM.Input) -> TrendingVM.Output {
        let movieInput = Driver.combineLatest(
            input.movieUpdateTrigger,
            input.timeWindow
        ) { $1 }
        
        let trendingMovies = movieInput
            .asObservable()
            .flatMap {
                self.repository.getTrendingMovies(time: $0)
            }.map { [MovieSection(movies: $0, header: nil)] }
            .asDriver(onErrorJustReturn: [])
        
        let showInput = Driver.combineLatest(
            input.showUpdateTrigger,
            input.timeWindow
        ) { $1 }
        
        let trendingShows = showInput
            .asObservable()
            .flatMap {
                self.repository.getTrendingShows(time: $0)
            }.map { [ShowSection(shows: $0, header: nil)] }
            .asDriver(onErrorJustReturn: [])
        
        let movieSelectedItem = input.movieSelectedTrigger
                .map { SelectedItem(mediaId: $0.id, type: .movie) }
        let showSelectedItem = input.showSelectedTrigger
                .map { SelectedItem(mediaId: $0.id, type: .tv) }
        
        let navigateToDetails = Driver.merge(movieSelectedItem, showSelectedItem)
        
        return Output(trendingMovies: trendingMovies, trendingShows: trendingShows, navigateToDetailsEvent: navigateToDetails)
    }
    
}
