//
//  MovieListDelegate.swift
//  TickledMedia
//
//  Created by ds-mayur on 2/13/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation
import UIKit

class MovieListDelegateFlowLayout : MovieListData, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    //MARK:- Delegate Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace    = (fetchMovieListPresenter?.sectionInsets.left ?? 0.0) * (Constants.movieListItemsPerRow + 1)
        let availableWidth  = UIScreen.main.bounds.width - paddingSpace
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
    }
    
}
