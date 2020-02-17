//
//  FetchMoviePresenterTest.swift
//  TickledMediaTMDBTests
//
//  Created by ds-mayur on 2/16/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import XCTest
@testable import TickledMediaTMDB

class FetchMoviePresenterTest : XCTestCase {
    
    var dataSource : MovieListDataSource!
    var delegate : MovieListDelegateFlowLayout!
    var prefetch : MovieListPrefetchingDataSource!
    var presenter : FetchMoviePresenter!
    fileprivate var service : MockMovieListService!
    
    override func setUp() {
        super.setUp()
        dataSource = MovieListDataSource()
        delegate = MovieListDelegateFlowLayout()
        prefetch = MovieListPrefetchingDataSource()
        service = MockMovieListService()
        
        presenter = FetchMoviePresenter(service: service, dataSource: dataSource, delegate: delegate, prefetchDataSource: prefetch)
    }
    
    override func tearDown() {
        super.tearDown()
        dataSource = nil
        delegate = nil
        prefetch = nil
        
    }
    
    func testFetchMoviesListWithNoService(){
        
        // giving no service to a view model
        presenter.service = nil
        
        presenter.fetchMovieList()
        
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
        let movieResult = MovieResult(id: 1, video: false, voteCount: 2272, voteAverage: 7, title: "Frozen II", releaseDate: "2019-11-20", originalLanguage: "en", originalTitle: "Frozen II", genreIDS: [12,16,10751], backdropPath: "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg", adult: false, overview: "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.", posterPath: "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg", popularity: 292.009, mediaType: "movie")
        
        let movieList = MovieListModel(results: [movieResult])
        
        //Fetching the movie list
        presenter.fetchMovieList()
        
        // giving a service mocking movies
        service.movieListModel = movieList
        
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

fileprivate class MockMovieListService : FetchMoviesServiceProtocol{
    
    var movieListModel: MovieListModel?
    
    func fetchMovieList(parameter: [String : String], _ completion: @escaping ((Result<MovieListModel, ErrorResult>) -> Void)) {
        
        if let movieList = movieListModel{
            completion(.success(movieList))
        }else{
            completion(.failure(ErrorResult.custom(string: "No Movie List")))
        }
    }
}

