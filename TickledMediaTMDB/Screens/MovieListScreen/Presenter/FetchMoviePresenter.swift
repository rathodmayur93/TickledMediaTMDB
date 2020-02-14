//
//  FetchMoviePresenter.swift
//  TickledMedia
//
//  Created by ds-mayur on 2/12/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation
import UIKit

protocol FetchedMovieSuccessfully {
    func reloadCollectionView()
}

class FetchMoviePresenter {
    
    //MARK: Variables
    private var service             : FetchMoviesServiceProtocol?
    private weak var dataSource     : MovieListDataSource?
    private weak var delegate       : MovieListDelegateFlowLayout?
    private weak var prefetchData   : MovieListPrefetchingDataSource?
    var onErrorHandling             : ((ErrorResult?) -> Void)?
    private var parameters          : [String : String]?
    
    var movieListModel                      : MovieListModel?
    var fetchedMovieSuccessfullyDelegate    : FetchedMovieSuccessfully?
    
    let sectionInsets   = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    private var currentPage = 1
    private var totalPages  = 1
    private var isFetchInProgress = false
    
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
    func fetchMovieList(service: FetchMoviesServiceProtocol = FetchMoviesService.shared){
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        //Show loader while loading first page only
        if(currentPage == 1){
            UiUtility.showIndicatorLoader()
        }
        
        parameters = ["api_key" : Constants.apiKey, "page" : "\(currentPage)"]
        
        guard let queryParamter = parameters else { return }
        
        service.fetchMovieList(parameter: queryParamter) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let movieList):
                    print("============================= Movie List API Response Sucess ============================= ")
                    self.handleFetchMovieAPIResponse(movieList: movieList)
                case .failure(let error):
                    self.isFetchInProgress = false
                    print("API Error : \(error)")
                }
                
                UiUtility.hideIndicatorLoader()
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
    
    private func calculateIndexPathsToReload(newMovieList: [MovieResult]) -> [IndexPath] {
        let startIndex = currentItemsCount - newMovieList.count
        let endIndex = startIndex + 10//newMovieList.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
