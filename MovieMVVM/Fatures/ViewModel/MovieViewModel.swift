//
//  MovieViewModel.swift
//  MovieMVVM
//
//  Created by İSMAİL AÇIKYÜREK on 1.08.2022.
//



import UIKit
import Alamofire
import Kingfisher


protocol DashboardViewModelProtocol {
    func initialize()
    func setUpDelegate(_ viewController: MainViewController)
    func setUpDelegate(_ viewController: DetailsViewController)
    func theMovieServiceSearch(search : String)
    func theMovieServiceSimilar(id : Int)
}

protocol DashboardViewModelOutputProtocol {
    func showDataNowPlaying(content: NowPlaying)
    func showDataUpcoming(content: Upcoming)
    func showDataSearch(content: Search)
    func showDataSimilar(content: Similar)
}

class DashboardViewModel:NSObject {
    private let service: MovieDataServiceProtokol = MovieDataService()
    var delegate: DashboardViewModelOutputProtocol?

    func initialize() {
        theMovieDbServicee()
    }
    
     func theMovieDbServicee() {
        let urlNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
        service.fethAllPostsNowPlaying(url: urlNowPlaying) { [weak self] model in
            self?.delegate?.showDataNowPlaying(content: model)
            
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
         
let urlUpcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
         service.fethAllPostsUpcoming(url: urlUpcoming) { model in
             self.delegate?.showDataUpcoming(content: model)
         } onFail: { error in
             print(error?.description ?? "An error occured")
         }
 }
    func theMovieServiceSearch(search : String) {
       let urlSearch = "https://api.themoviedb.org/3/search/movie?api_key=e1f05eb6d6888cc4a751a49802070b48&query=\(search)"
        print(urlSearch)
       service.fethAllPostsSearch(url: urlSearch) { [weak self] model in
           self?.delegate?.showDataSearch(content: model)
       } onFail: { error in
           print(error?.description ?? "An error occured")
       }
    }
    
   func theMovieServiceSimilar(id : Int) {
       let urlSimilar = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
       service.fethAllPostsSimilar(url: urlSimilar) { [weak self] model in
           self?.delegate?.showDataSimilar(content: model)
       } onFail: { error in
           print(error?.description ?? "An error occured")
       }
    }
    
    
}

extension DashboardViewModel: DashboardViewModelProtocol {
    func setUpDelegate(_ viewController: DetailsViewController) {
        delegate = viewController as! DashboardViewModelOutputProtocol
    }
    
   
    func setUpDelegate(_ viewController: MainViewController) {
        delegate = viewController as! DashboardViewModelOutputProtocol
    }
    
}

