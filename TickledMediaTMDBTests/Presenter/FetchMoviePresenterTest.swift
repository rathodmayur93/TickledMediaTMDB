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
        dataSource = nil
        delegate = nil
        prefetch = nil
        super.tearDown()
    }
    
    func testFetchMoviesListWithNoService(){
        
        let expectation = XCTestExpectation(description: "No service")
        
        // giving no service to a view model
        presenter.service = nil
        
        // expected to not be able to fetch currencies
        presenter.onErrorHandling = { error in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        
        presenter.fetchMovieList()
    }
    
    func testMovieListWithMovieList(){
        
        // giving data value
        let movieResult = MovieResult(id: 1, video: false, voteCount: 2272, voteAverage: 7, title: "Frozen II", releaseDate: "2019-11-20", originalLanguage: "en", originalTitle: "Frozen II", genreIDS: [12,16,10751], backdropPath: "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg", adult: false, overview: "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.", posterPath: "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg", popularity: 292.009, mediaType: "movie")
        
        let movieList = MovieListModel(results: [movieResult])
        
        // giving a service mocking currencies
        service.movieListModel = movieList
        
        presenter.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        
        presenter.fetchMovieList()
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

