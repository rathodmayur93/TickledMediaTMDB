//
//  MovieDetailViewPresenter.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/15/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation

protocol MovieDetailDelegate {
    func movieDetailLoadedSuccessfully()
    func movieDetailFailedToLoad()
}

class MovieDetailViewPresenter{
    
    //MARK: Variables
    var service : FetchMovieDetailServiceProtocol?
    var movieDetaiModel : MovieDetailModel?
    var errorResult : ErrorResult?
    var movieDetailDelegate : MovieDetailDelegate?
    
    //Computed Variables
    var posterImageView : String{
        return Constants.imageBaseUrl + (movieDetaiModel?.backdropPath ?? "")
    }
    
    var movieTitle : String{
        return movieDetaiModel?.title ?? ""
    }
    
    var movieTagline : String{
        return movieDetaiModel?.tagline ?? ""
    }
    
    var movieDescription : String{
        return movieDetaiModel?.overview ?? ""
    }
    
    var movieRuntime : String{
        return calculateMovieRuntime()
    }
    
    var movieVote : String{
        return "\(movieDetaiModel?.voteAverage ?? 0)/10"
    }
    
    var movieReleaseDate : String{
        return movieDetaiModel?.releaseDate ?? ""
    }
    
    //MARK:- Init
    init(service: FetchMovieDetailServiceProtocol = FetchMovieDetailService.shared) {
        self.service = service
    }
    
    //This function will convert the movie runtime minutes into the Hour and minute
    private func calculateMovieRuntime() -> String{
        
        let movieLength = movieDetaiModel?.runtime ?? 0.0
        let hours = Int(movieLength / 60.0)
        let min = Int(movieLength) % 60
        return "\(hours) hr \(min) min"
    }
    
    //MARK: - API Calls
    func fetchMovieDetailAPICall(movieId : Int){
        
        //Check whether internet connection is there or not
        if !InternetConnectionManager.isConnectedToNetwork(){
            print("No Internet Connection")
            errorResult = ErrorResult.custom(string: "No Internet Conenction")
            //Calling the delegate method to show an error
            self.movieDetailDelegate?.movieDetailFailedToLoad()
            return
        }
        
        //Show Indicator loader
        Utility.showIndicatorLoader()
        
        //Unwrapping the servic
        guard let service = service else {
            errorResult = ErrorResult.custom(string: "Missing Service")
            self.movieDetailDelegate?.movieDetailFailedToLoad()
            return
        }
        
        //Fetching the movie detail by making an api call
        service.fethcMovieDetail(movieId: movieId, parameter: ServiceParameters.movieDetailParams(), { (result) in
            
            //Updating the UI on the main thread
            DispatchQueue.main.async {
                
                switch result{
                //Successfully fetch the movie list now updating UI
                case .success(let movieDetailModel):
                    
                    self.movieDetaiModel = movieDetailModel
                    self.movieDetailDelegate?.movieDetailLoadedSuccessfully()
                    break
                //Unable to fetch the movie details
                case .failure(let error):
                    self.errorResult = error
                    self.movieDetailDelegate?.movieDetailFailedToLoad()
                    print("Movie Detail Error \(error)")
                }
                
                //Hide indicator loader
                Utility.hideIndicatorLoader()
            }
        })
    }
}
