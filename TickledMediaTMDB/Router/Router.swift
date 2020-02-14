//
//  Router.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/15/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

final class Router{
    
    //MARK:- This function will push the viewController over the other view controller
    static func pushControllerNavigation(identifierName : String, storyboardName : String, fromController controller : UIViewController){
        
        let mainStoryboard          = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let vc : UIViewController   = mainStoryboard.instantiateViewController(withIdentifier: identifierName) as UIViewController
        vc.modalPresentationStyle   = .custom
        vc.modalTransitionStyle     = .crossDissolve
        controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func navigateToMovieDetailScreen(fromController controller : UIViewController, movieId : Int){
        
        let mainStoryboard                  = UIStoryboard(name: Constants.mainStoryboard, bundle: Bundle.main)
        let vc : MovieDetailViewController  = mainStoryboard.instantiateViewController(withIdentifier: Constants.movieDetailVC) as! MovieDetailViewController
        vc.movieId = movieId
        vc.modalPresentationStyle = .automatic
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}
