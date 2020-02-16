//
//  FetchMovieDetailAPI.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/14/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation

protocol FetchMovieDetailServiceProtocol  {
    func fethcMovieDetail(movieId : Int, parameter: [String : String], _ completion: @escaping ((Result<MovieDetailModel, ErrorResult>) -> Void))
}

class FetchMovieDetailService : RequestHandler, FetchMovieDetailServiceProtocol {
    
    //Creating the singleton instance of the FetchMoviesService
    static let shared = FetchMovieDetailService()
    var task : URLSessionTask?
    
    func fethcMovieDetail(movieId : Int, parameter: [String : String], _ completion: @escaping ((Result<MovieDetailModel, ErrorResult>) -> Void)) {
        
        let endpoint = Endpoint.movieDetail(movieId: movieId).path
        
        // cancel previous request if already in progress
        self.cancelFetchMovieDetail()
        
        let networkResult = self.networkResultData(completion: completion)
        task = RequestService().loadData(urlString: endpoint, parameters: parameter, completion: networkResult)
        
    }
    
    func cancelFetchMovieDetail() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
