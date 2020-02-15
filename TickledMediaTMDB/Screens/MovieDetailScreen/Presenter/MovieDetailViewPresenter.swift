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
    private var service : FetchMovieDetailServiceProtocol?
    var movieDetaiModel : MovieDetailModel?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    var movieDetailDelegate : MovieDetailDelegate?
    
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
    
    private func calculateMovieRuntime() -> String{
        
        let movieLength = movieDetaiModel?.runtime ?? 0.0
        let hours = Int(movieLength / 60.0)
        let min = Int(movieLength) % 60
        return "\(hours) hr \(min) min"
    }
    
    //MARK: - API Calls
    func fetchMovieDetailAPICall(movieId : Int){
        
        //Show Indicator loader
        UiUtility.showIndicatorLoader()
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing Service"))
            return
        }
        
        service.fethcMovieDetail(movieId: movieId, parameter: ServiceParameters.movieDetailParams(), { (result) in
            
            DispatchQueue.main.async {
                
                switch result{
                case .success(let movieDetailModel):
                    
                    self.movieDetaiModel = movieDetailModel
                    self.movieDetailDelegate?.movieDetailLoadedSuccessfully()
                    break
                case .failure(let error):
                    self.onErrorHandling?(error)
                    self.movieDetailDelegate?.movieDetailFailedToLoad()
                    print("Movie Detail Error \(error)")
                }
                
                //Hide indicator loader
                UiUtility.hideIndicatorLoader()
            }
        })
    }
}
