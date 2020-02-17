//
//  MovieListDelegate.swift
//  TickledMedia
//
//  Created by ds-mayur on 2/13/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation
import UIKit

protocol MovieSelectedDelegate {
    func didSelectMovie(movieId : Int)
}

class MovieListDelegateFlowLayout : MovieListData, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    //MARK:- Delegate Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Calculating the available padding space require
        let paddingSpace    = (fetchMovieListPresenter?.sectionInsets.left ?? 0.0) * (Constants.movieListItemsPerRow + 1)
        //Calculate the available width we have for cell
        let availableWidth  = UIScreen.main.bounds.width - paddingSpace
        //Calculating the each cell width
        let widthPerItem    = availableWidth / (Constants.movieListItemsPerRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return fetchMovieListPresenter?.sectionInsets ?? UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return fetchMovieListPresenter?.sectionInsets.left ?? 0.0
    }
    
    //MARK:- UICollectionViewDelegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected movie \(String(describing: fetchMovieListPresenter?.fetchMovieName(atIndex: indexPath.item)))")
        
        //Fetching the movieId
        let movieId = fetchMovieListPresenter?.movieListModel?.results?[indexPath.item].id ?? 0
        
        //Passing movieId to viewController using delegates
        fetchMovieListPresenter?.movieSelectedDelegate?.didSelectMovie(movieId: movieId)
    }
    
}
