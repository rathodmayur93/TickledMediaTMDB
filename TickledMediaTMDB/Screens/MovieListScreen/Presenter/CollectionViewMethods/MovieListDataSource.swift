//
//  MovieListDataSource.swift
//  TickledMedia
//
//  Created by ds-mayur on 2/13/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

class MovieListData : NSObject{
    var fetchMovieListPresenter : FetchMoviePresenter?
}

class MovieListDataSource : MovieListData, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchMovieListPresenter?.movieListModel?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieListCellName, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        if let moviePresenter = fetchMovieListPresenter{
            cell.setupCell(fetchMoviePresenter: moviePresenter, itemIndex: indexPath.item)
        }
        
        print("Movie Name \(fetchMovieListPresenter?.movieListModel?.results?[indexPath.item].originalTitle ?? "No Name")")
        return cell
    }
}
