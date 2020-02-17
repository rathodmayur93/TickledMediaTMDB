//
//  FetchMoviePresenter.swift
//  TickledMedia
//
//  Created by ds-mayur on 2/12/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation
import UIKit

protocol FetchedMovieSuccessfullyDelegate {
    func reloadCollectionView()
    func failedToLoadMovieList()
}

class FetchMoviePresenter {
    
    //MARK: Variables
    var service                     : FetchMoviesServiceProtocol?
    private weak var dataSource     : MovieListDataSource?
    private weak var delegate       : MovieListDelegateFlowLayout?
    private weak var prefetchData   : MovieListPrefetchingDataSource?
    
    var movieListModel                      : MovieListModel?
    var fetchedMovieSuccessfullyDelegate    : FetchedMovieSuccessfullyDelegate?
    var movieSelectedDelegate               : MovieSelectedDelegate?
    
    let sectionInsets   = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    private var currentPage = 1
    private var totalPages  = 1
    private var isFetchInProgress = false
    var errorResult : ErrorResult?
    
    var totalPagesCount : Int{
        return totalPages
    }
    
    var currentItemsCount : Int{
        return movieListModel?.results?.count ?? 0
    }
    
    //MARK:- Init
    init(service: FetchMoviesServiceProtocol = FetchMoviesService.shared,
         dataSource : MovieListDataSource,
         delegate : MovieListDelegateFlowLayout,
         prefetchDataSource : MovieListPrefetchingDataSource) {
        
        self.service = service
        self.dataSource = dataSource
        self.delegate = delegate
        self.prefetchData = prefetchDataSource
    }
    
    private func passDataToDataSource(){
        dataSource?.fetchMovieListPresenter = self
        delegate?.fetchMovieListPresenter = self
        prefetchData?.fetchMovieListPresenter = self
        
    }
    
    //MARK:- Fetching Movie Values
    func fetchMovieName(atIndex : Int) -> String{
        return movieListModel?.results?[atIndex].title ?? ""
    }
    
    func fetchMoviePosterUrl(atIndex : Int) -> String{
        return Constants.imageBaseUrl + (movieListModel?.results?[atIndex].posterPath ?? "")
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= currentItemsCount
    }
    
    //MARK: - API Calls
    func fetchMovieList(){
        
        if !InternetConnectionManager.isConnectedToNetwork(){
            print("No Internet Connection")
            errorResult = ErrorResult.custom(string: "No Internet Connection")
            fetchedMovieSuccessfullyDelegate?.failedToLoadMovieList()
            return
        }
        
        guard let service = service else {
            errorResult = ErrorResult.custom(string: "Missing Service")
            fetchedMovieSuccessfullyDelegate?.failedToLoadMovieList()
            return
        }
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        //Show loader while loading first page only
        if(currentPage == 1){
            Utility.showIndicatorLoader()
        }
        
        service.fetchMovieList(parameter: ServiceParameters.movieListParams(currentPage: currentPage)) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let movieList):
                    print("============================= Movie List API Response Sucess ============================= ")
                    self.handleFetchMovieAPIResponse(movieList: movieList)
                case .failure(let error):
                    self.isFetchInProgress = false
                    self.errorResult = error
                    self.fetchedMovieSuccessfullyDelegate?.failedToLoadMovieList()
                    print("API Error : \(error)")
                }
                
                Utility.hideIndicatorLoader()
            }
        }
    }
    
    //MARK:- Response Handlers
    //Handling the API Response
    private func handleFetchMovieAPIResponse(movieList : MovieListModel){
        
        //Api call is done now make the flag as false
        isFetchInProgress = false
        
        //Handling the pagination event
        paginationHandler(movieList: movieList)
        
        //Reloading the collectionView
        self.fetchedMovieSuccessfullyDelegate?.reloadCollectionView()
        
        //Inceasing the page count by one
        currentPage += 1
        
        //pasing the data source
        self.passDataToDataSource()
    }
    
    private func paginationHandler(movieList : MovieListModel){
        
        /*
         - if condition will check whether the current page is equal to 1 or not
         - If the current page is equal to 1 means its fetching the movie list for the first time
         - If the current page is more than 1 means we have to append the result at the end of the of list
         */
        if(currentPage > 1){
            movieListModel?.results! += movieList.results!
        }else{
            movieListModel = movieList
        }
    }
}
