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
    let dataSource = MovieListDataSource()
    let delegate = MovieListDelegate()
    let flowDelegate = MovieListDelegateFlowLayout()
    let prefetchDataSource = MovieListPrefetchingDataSource()
    
    //Setting up the presenter
    lazy var fetchMoviePresenter : FetchMoviePresenter = {
        let presenter = FetchMoviePresenter(dataSource: dataSource,
                                            delegate: delegate,
                                            delegateFlow: flowDelegate,
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
        
        //Setting up the collectionView
        setupCollectionView()
        
        //Fetch the movies api call
        fetchMoviePresenter.fetchMovieList()
        fetchMoviePresenter.fetchedMovieSuccessfullyDelegate = self
    }
    
    //Setting up the collectionView
    private func setupCollectionView(){
        //Setting up the collectionView XIB
        setupCollectionViewXIB()
        
        movieCollectionView.dataSource = dataSource
        movieCollectionView.delegate = delegate
        movieCollectionView.delegate = flowDelegate
        //movieCollectionView.prefetchDataSource = prefetchDataSource
        //movieCollectionView.collectionViewLayout = flowDelegate
        
    }
    
    //Setting up the collectionView XIB
    private func setupCollectionViewXIB(){
        movieCollectionView.register(UINib(nibName: Constants.movieListCollectionViewCell, bundle: nil),
                                     forCellWithReuseIdentifier: Constants.movieListCellName)
        
    }
}


extension ViewController : FetchedMovieSuccessfully{
    
    func reloadCollectionView() {
        movieCollectionView.reloadData()
    }
}
