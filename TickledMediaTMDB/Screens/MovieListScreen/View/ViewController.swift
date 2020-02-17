//
//  ViewController.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/13/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    //MARK:- Variables
    private let dataSource = MovieListDataSource()
    private let delegate = MovieListDelegateFlowLayout()
    private let prefetchDataSource = MovieListPrefetchingDataSource()
    private let refreshControl = UIRefreshControl()
    
    private var errorMessage : String?
    
    //Setting up the presenter
    lazy var fetchMoviePresenter : FetchMoviePresenter = {
        let presenter = FetchMoviePresenter(dataSource: dataSource,
                                            delegate: delegate,
                                            prefetchDataSource: prefetchDataSource)
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the UI elements
        setUI()
    }
    
    //Setting up the UI elements
    private func setUI(){
        
        //Setting up the refresh control
        setupRefreshControl()
        
        //Setting up the collectionView
        setupCollectionView()
        
        //Setting up the delegate method
        fetchMoviePresenter.fetchedMovieSuccessfullyDelegate = self
        fetchMoviePresenter.movieSelectedDelegate = self
        
        //Fetching the movie list
        fetchMovieListAPI()
    }
    
    //Setting up the refresh control
    func setupRefreshControl(){
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(fetchMovieListAPI), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Movie Data ...")
    }
    
    //Fetching the  movieList from server
    @objc func fetchMovieListAPI(){
        //Fetch the movies api call
        fetchMoviePresenter.fetchMovieList()
    }
    
    //Setting up the collectionView
    private func setupCollectionView(){
        
        movieCollectionView.accessibilityIdentifier = TestUIElementKeys.movieListCollectionView
        
        //Setting up the collectionView XIB
        setupCollectionViewXIB()
        
        movieCollectionView.dataSource = dataSource
        movieCollectionView.delegate = delegate
        movieCollectionView.prefetchDataSource = prefetchDataSource
        
        
        movieCollectionView.addSubview(refreshControl)
    }
    
    //Setting up the collectionView XIB
    private func setupCollectionViewXIB(){
        movieCollectionView.register(UINib(nibName: Constants.movieListCollectionViewCell, bundle: nil),
                                     forCellWithReuseIdentifier: Constants.movieListCellName)
        
    }
    
    //MARK: Show Error
    private func showErrorMessage(){
        
        //Updating the UI on the main thread
        DispatchQueue.main.async {
            
            //Unwrapping the errorResult
            guard let errorResult = self.fetchMoviePresenter.errorResult else { return }
            //Fetching the errorMessage
            let errorMessage = Utility.retrieveErrorMessage(errorResult: errorResult)
            
            //Display an alert box with error message
            let controller = UIAlertController(title: Constants.alertBoxHeading,
                                               message: errorMessage,
                                               preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension ViewController : FetchedMovieSuccessfullyDelegate{
    
    //This funciton will update the UI when api call is successful and model contain valid data
    func reloadCollectionView() {
        refreshControl.endRefreshing()
        movieCollectionView.reloadData()
    }
    
    //If there is any error while invoking the api service this method will get called
    func failedToLoadMovieList() {
        refreshControl.endRefreshing()
        showErrorMessage()
    }
}

extension ViewController : MovieSelectedDelegate{
    
    //Whenever user tap on any movie this method will be invoked
    func didSelectMovie(movieId: Int) {
        //Router will help us to navigate to the MovieDetailScreen
        Router.navigateToMovieDetailScreen(fromController: self, movieId: movieId)
    }
    
    
}
