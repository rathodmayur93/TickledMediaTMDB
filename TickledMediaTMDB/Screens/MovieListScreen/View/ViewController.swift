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
        
        fetchMoviePresenter.onErrorHandling = { [weak self] error in
            // display error ?
            let controller = UIAlertController(title: Constants.alertBoxHeading, message: error?.localizedDescription, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
    }
}

extension ViewController : FetchedMovieSuccessfullyDelegate{

    func reloadCollectionView() {
        refreshControl.endRefreshing()
        movieCollectionView.reloadData()
    }
    
    func failedToLoadMovieList() {
        refreshControl.endRefreshing()
        showErrorMessage()
     }
}

extension ViewController : MovieSelectedDelegate{
    
    func didSelectMovie(movieId: Int) {
        Router.navigateToMovieDetailScreen(fromController: self, movieId: movieId)
    }
    
    
}
