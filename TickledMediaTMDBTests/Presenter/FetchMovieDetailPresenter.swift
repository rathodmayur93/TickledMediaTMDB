//
//  FetchMovieDetailPresenter.swift
//  TickledMediaTMDBTests
//
//  Created by ds-mayur on 2/17/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import XCTest
@testable import TickledMediaTMDB

class FetchMovieDetailPresenterTest : XCTestCase {
    
    var presenter : MovieDetailViewPresenter!
    fileprivate var service : MockMovieDetailService!
    
    override func setUp() {
        super.setUp()
        service = MockMovieDetailService()
        presenter = MovieDetailViewPresenter(service: service)
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
        
    }
    
    func testFetchMoviesDetailWithNoService(){
        
        // giving no service to a view model
        presenter.service = nil
        
        presenter.fetchMovieDetailAPICall(movieId: 1)
        
        // expected to not be able to fetch currencies
        switch presenter.errorResult {
        case .custom( _):
            XCTAssertTrue(true, "ViewModel should not be able to fetch without service")
        default:
            return
        }
    }
    
    func testMovieListWithMovieList(){
        
        // giving data value
        let movieDetailModel = MovieDetailModel(adult: false, backdropPath: "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg", budget: 11363000, genres: nil, homepage: "https://www.parasite-movie.com/", id: 496243, imdbID: "tt6751668", originalLanguage: "ko", originalTitle: "기생충", overview: "All unemployed, Ki-taek's family takes peculiar interest in the wealthy and glamorous Parks for their livelihood until they get entangled in an unexpected incident.", popularity: 358.622, posterPath: "/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg", productionCompanies: nil, productionCountries: nil, releaseDate: "2019-05-30", revenue: 165923763, runtime: 132, spokenLanguages: nil, status: "Released", tagline: "Act like you own the place.", title: "Parasite", video: false, voteAverage: 8.6, voteCount: 3926)
        
        //Fetching the movie list
        presenter.fetchMovieDetailAPICall(movieId: 496243)
        
        // giving a service mocking movies
        service.movieDetailModel = movieDetailModel
        
        // expected to not be able to fetch movies
        switch presenter.errorResult {
        case .custom( _):
            XCTAssertTrue(false, "ViewModel should not be able to fetch without service")
        case .network( _):
            XCTAssertTrue(false, "ViewModel should not be able to fetch without service")
        case .parser( _):
            XCTAssertTrue(false, "ViewModel should not be able to fetch without service")
        default:
            XCTAssertTrue(true, "Error result is nil means service is working fine")
        }
    }
}

fileprivate class MockMovieDetailService : FetchMovieDetailServiceProtocol{
    
    var movieDetailModel: MovieDetailModel?
    
    func fethcMovieDetail(movieId: Int,
                          parameter: [String : String],
                          _ completion: @escaping ((Result<MovieDetailModel, ErrorResult>) -> Void)) {
        
        if let movieDetail = movieDetailModel{
            completion(.success(movieDetail))
        }else{
            completion(.failure(ErrorResult.custom(string: "No Movie List")))
        }
    }
    
}
