//
//  FetchMoviesService.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/14/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation

protocol FetchMoviesServiceProtocol {
    func fetchMovieList(parameter: [String : String], _ completion: @escaping ((Result<MovieListModel, ErrorResult>) -> Void))
}

final class FetchMoviesService : RequestHandler, FetchMoviesServiceProtocol{
    
    //Creating the singleton instance of the FetchMoviesService
    static let shared = FetchMoviesService()
    
    let endpoint = Endpoint.movieList.path
    var task : URLSessionTask?
    
    func fetchMovieList(parameter : [String : String], _ completion: @escaping ((Result<MovieListModel, ErrorResult>) -> Void)) {
        // cancel previous request if already in progress
        self.cancelFetchMovieList()
        task = RequestService().loadData(urlString: endpoint,
                                         parameters: parameter,
                                         completion: self.networkResultData(completion: completion))
    }
    
    
    func cancelFetchMovieList() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
