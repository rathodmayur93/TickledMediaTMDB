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
    
    
    /**
     This method will fetch the response by making an api call and then convert it into the respecitve model
     
     - parameter movieId: Request movie detail id
     - parameter parameter: parameter for the movie detail api
     - returns: Completion handler containing the result of MovieDetailModel and ErrorResult
    */
    func fethcMovieDetail(movieId : Int, parameter: [String : String], _ completion: @escaping ((Result<MovieDetailModel, ErrorResult>) -> Void)) {
        
        let endpoint = Endpoint.movieDetail(movieId: movieId).path
        
        // cancel previous request if already in progress
        self.cancelFetchMovieDetail()
        
        let networkResult = self.networkResultData(completion: completion)
        task = RequestService().loadData(urlString: endpoint, parameters: parameter, completion: networkResult)
        
    }
    
    //Cancel the fetch movie detail task
    func cancelFetchMovieDetail() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
