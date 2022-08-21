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
    func theMovieServiceSearch(search : String)
}

protocol DashboardViewModelOutputProtocol {
    func showDataNowPlaying(content: NowPlaying)
    func showDataUpcoming(content: Upcoming)
    func showDataSearch(content: Search)
}

class DashboardViewModel:NSObject {
    private let service: MovieDataServiceProtokol = MovieDataService()
    var delegate: DashboardViewModelOutputProtocol?

    func initialize() {
        theMovieDbServicee()
    }
    
     func theMovieDbServicee() {
        let urlNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
        service.fethAllPosts(url: urlNowPlaying) { [weak self] model in
            self?.delegate?.showDataNowPlaying(content: model)
            
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
         
let urlUpcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
         service.fethAllPosts(url: urlUpcoming) { model in
             self.delegate?.showDataUpcoming(content: model)
         } onFail: { error in
             print(error?.description ?? "An error occured")
         }
 }
    func theMovieServiceSearch(search : String) {
       let urlSearch = "https://api.themoviedb.org/3/search/movie?api_key=e1f05eb6d6888cc4a751a49802070b48&query=\(search)"
        print(urlSearch)
       service.fethAllPosts(url: urlSearch) { [weak self] model in
           self?.delegate?.showDataSearch(content: model)
       } onFail: { error in
           print(error?.description ?? "An error occured")
       }
    }
}

extension DashboardViewModel: DashboardViewModelProtocol {
    func setUpDelegate(_ viewController: MainViewController) {
        delegate = viewController as! DashboardViewModelOutputProtocol
    }
    
}

