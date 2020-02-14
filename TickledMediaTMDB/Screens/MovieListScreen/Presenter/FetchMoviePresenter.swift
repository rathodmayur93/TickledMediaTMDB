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
    private weak var delegate       : MovieListDelegate?
    private weak var delegateFlow   : MovieListDelegateFlowLayout?
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
         delegate : MovieListDelegate,
         delegateFlow : MovieListDelegateFlowLayout,
         prefetchDataSource : MovieListPrefetchingDataSource) {
        
        self.service = service
        self.dataSource = dataSource
        self.delegate = delegate
        self.delegateFlow = delegateFlow
        self.prefetchData = prefetchDataSource
    }
    
    private func passDataToDataSource(){
        dataSource?.fetchMovieListPresenter = self
        delegate?.fetchMovieListPresenter = self
        delegateFlow?.fetchMovieListPresenter = self
        //prefetchData?.fetchMovieListPresenter = self
        
    }
    
    //MARK:- Fetching Movie Values
    func fetchMovieName(atIndex : Int) -> String{
        return movieListModel?.results?[atIndex].originalTitle ?? ""
    }
    
    func fetchMoviePosterUrl(atIndex : Int) -> String{
        return Constants.imageBaseUrl + (movieListModel?.results?[atIndex].posterPath ?? "")
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
        self.movieListModel = movieList
        self.passDataToDataSource()
        
        isFetchInProgress = false
        currentPage += 1
        
        totalPages = movieList.totalPages ?? 0
        
        if (currentPage > 1){
            movieListModel?.results! += movieList.results!
//            let indexPathToReload = calculateIndexPathsToReload(newMovieList: movieList.results ?? [])
//            self.fetchedMovieSuccessfullyDelegate?.reloadCollectionViewIndexPaths(indexPaths: indexPathToReload)
            self.fetchedMovieSuccessfullyDelegate?.reloadCollectionView()
            
        }else{
            movieListModel = movieList
            self.fetchedMovieSuccessfullyDelegate?.reloadCollectionView()
        }
    }
    
    private func calculateIndexPathsToReload(newMovieList: [MovieResult]) -> [IndexPath] {
      let startIndex = currentItemsCount - newMovieList.count
      let endIndex = startIndex + newMovieList.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
