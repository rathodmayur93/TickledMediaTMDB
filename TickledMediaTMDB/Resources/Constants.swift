//
//  Constants.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/14/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    static let apiKey = "8eac22f4c24d01c480e4d99fef2edfc3"
    
    //API Urls
    static let baseUrl      = "http://api.themoviedb.org/3"
    static let imageBaseUrl = "http://image.tmdb.org/t/p/w342"
    
    //Endpoints
    static let movieList    = baseUrl + "/trending/movie/week"
    
    //Storyboard Names
    static let mainStoryboard = "Main"
    
    //UIViewController Names
    static let movieDetailVC = "MovieDetailViewController"
    
    //Cell names
    static let movieListCellName = "movieCell"
    
    //Storyboard and XIB names
    static let movieListCollectionViewCell = "MovieListCollectionViewCell"
    
    //MovieList Item per row value
    static let movieListItemsPerRow : CGFloat = 2
    
    //Alert Box Constants
    static let alertBoxHeading = "Error"
    static let alertActionButton = "Close"
}
