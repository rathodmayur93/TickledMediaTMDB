//
//  MovieListPrefetchingDataSource.swift
//  TickledMedia
//
//  Created by ds-mayur on 2/13/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

class MovieListPrefetchingDataSource : MovieListData, UICollectionViewDataSourcePrefetching{
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths{
            print("Prefetching =============> Index \(indexPath.item)")
            if(indexPath.item >= ((fetchMovieListPresenter?.currentItemsCount ?? 0) - 1)){
                print("=============== Pagination ==============")
                fetchMovieListPresenter?.fetchMovieList()
            }
        }
    }
}
