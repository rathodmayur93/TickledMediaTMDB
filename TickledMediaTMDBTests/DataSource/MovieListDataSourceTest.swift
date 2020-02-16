//
//  MovieListDataSource.swift
//  TickledMediaTMDBTests
//
//  Created by ds-mayur on 2/16/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import XCTest
@testable import TickledMediaTMDB

class MovieListDataSourceTest : XCTestCase{
    
    var dataSource : MovieListDataSource!
    var delegate : MovieListDelegateFlowLayout!
    var prefetch : MovieListPrefetchingDataSource!
    var presenter : FetchMoviePresenter!
    
    override func setUp() {
        super.setUp()
        dataSource = MovieListDataSource()
        delegate = MovieListDelegateFlowLayout()
        prefetch = MovieListPrefetchingDataSource()
        
        presenter = FetchMoviePresenter(dataSource: dataSource, delegate: delegate, prefetchDataSource: prefetch)
    }
    
    override func tearDown() {
        dataSource = nil
        delegate = nil
        prefetch = nil
        super.tearDown()
    }
    
    func testEmptyValueInDataSource() {
        
        let movieListModel = MovieListModel()
        
        dataSource.fetchMovieListPresenter = presenter
        dataSource.fetchMovieListPresenter?.movieListModel = movieListModel
        
        // giving empty data value
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1, "Expected one section in collection view")
        
        // expected zero cells
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 0, "Expected no cell in collection view")
    }
    
    func testValueInDataSource() {
        
        // giving data value
        let movieResult = MovieResult(id: 1, video: false, voteCount: 2272, voteAverage: 7, title: "Frozen II", releaseDate: "2019-11-20", originalLanguage: "en", originalTitle: "Frozen II", genreIDS: [12,16,10751], backdropPath: "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg", adult: false, overview: "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.", posterPath: "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg", popularity: 292.009, mediaType: "movie")
        
        let movieListModel = MovieListModel(results: [movieResult])
        
        dataSource.fetchMovieListPresenter = presenter
        dataSource.fetchMovieListPresenter?.movieListModel = movieListModel
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1, "Expected one section in table view")
        
        // expected two cells
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 1), 1, "Expected one cell in collection view")
    }
}
