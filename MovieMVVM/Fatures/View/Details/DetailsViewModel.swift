//
//  DetailsViewModel.swift
//  MovieMVVM
//
//  Created by İSMAİL AÇIKYÜREK on 2.08.2022.
//


import UIKit
import Alamofire
import Kingfisher


protocol DetailsViewModelProtocol {
    func initialize()
    func setUpDelegate(_ viewController: DetailsViewController)
    func theMovieServiceSimilar(id : Int)
}

protocol DetailsViewModelOutputProtocol {
    func showDataSimilar(content: Similar)
}

class DetailsViewModel:NSObject {
    private let service: MovieDataServiceProtokol = MovieDataService()
    var delegate: DetailsViewModelOutputProtocol?

    func initialize() {
       // theMovieDbServicee()
    }
    
    
   func theMovieServiceSimilar(id : Int) {
       let urlSimilar = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=e1f05eb6d6888cc4a751a49802070b48&language=en-US&page=1"
       service.fethAllPosts(url: urlSimilar) { [weak self] model in
           self?.delegate?.showDataSimilar(content: model)
       } onFail: { error in
           print(error?.description ?? "An error occured")
       }
    }
    
    
}

extension DetailsViewModel: DetailsViewModelProtocol {

    func setUpDelegate(_ viewController: DetailsViewController) {
        delegate = viewController as! DetailsViewModelOutputProtocol
    }
    
    
}

