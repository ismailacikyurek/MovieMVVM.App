//
//  Service.swift
//  MovieMVVM
//
//  Created by İSMAİL AÇIKYÜREK on 1.08.2022.
//

import Foundation
import UIKit
import Alamofire


//MARK: Protocol
protocol MovieDataServiceProtokol {
    func fethAllPostsNowPlaying(url:String,onSuccess: @escaping (NowPlaying) -> Void, onFail: @escaping (String?) -> Void)
    func fethAllPostsUpcoming(url:String,onSuccess: @escaping (Upcoming) -> Void, onFail: @escaping (String?) -> Void)
    func fethAllPostsSearch(url:String,onSuccess: @escaping (Search) -> Void, onFail: @escaping (String?) -> Void)
    func fethAllPostsSimilar(url:String,onSuccess: @escaping (Similar) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Get Datas
struct MovieDataService: MovieDataServiceProtokol {
    func fethAllPostsSimilar(url: String, onSuccess: @escaping (Similar) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of:Similar.self) { (response) in
            guard let items =  response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
    
    func fethAllPostsSearch(url: String, onSuccess: @escaping (Search) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of:Search.self) { (response) in
            guard let items =  response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
    
    func fethAllPostsUpcoming(url: String, onSuccess: @escaping (Upcoming) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of:Upcoming.self) { (response) in
            guard let items =  response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
    
    func fethAllPostsNowPlaying(url: String, onSuccess: @escaping (NowPlaying) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of:NowPlaying.self) { (response) in
            guard let items =  response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
    
    
    
    
}
