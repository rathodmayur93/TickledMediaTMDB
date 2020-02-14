//
//  MovieDetailViewController.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/14/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    //MARK: Varibales
    var movieId : Int? 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let selectedMovieId = movieId else { return }
        
        FetchMovieDetailService.shared.fethcMovieDetail(movieId: selectedMovieId, parameter: ServiceParameters.movieDetailParams()) { (result) in
            switch result{
            case .success(let movieDetail):
                print("Movie Detail ✅ \(movieDetail)")
            case .failure(let error):
                print("Movie Detail ❌ \(error)")
            }
        }
    }

}
