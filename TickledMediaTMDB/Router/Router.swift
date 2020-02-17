//
//  Router.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/15/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

final class Router{
    
    //MARK:- Navigate to the Movie Detail Screen
    static func navigateToMovieDetailScreen(fromController controller : UIViewController, movieId : Int){
        
        //Fetching the storyBoard and creating the MovieDetailViewController object
        let mainStoryboard                  = UIStoryboard(name: Constants.mainStoryboard, bundle: Bundle.main)
        let vc : MovieDetailViewController  = mainStoryboard.instantiateViewController(withIdentifier: Constants.movieDetailVC) as! MovieDetailViewController

        vc.movieId = movieId
        vc.modalPresentationStyle = .automatic
        
        //For Navigation Controller push the ViewController using below line
        //controller.navigationController?.pushViewController(vc, animated: true)
        
        //Navigate to the movie detail screen
        controller.present(vc, animated: true, completion: nil)
    }
}
