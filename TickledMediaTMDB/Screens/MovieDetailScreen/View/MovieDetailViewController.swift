//
//  MovieDetailViewController.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/14/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTagLineLabel: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    //MARK: Varibales
    var movieId : Int?
    var movieDetailModel : MovieDetailModel?
    
    //Setting up the presenter
    lazy var movieDetailPresenter : MovieDetailViewPresenter = {
        let presenter = MovieDetailViewPresenter()
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the UI
        setUI()
    }
    
    //Setting up the UI Functions
    private func setUI(){
        
        guard let selectedMovieId = movieId else { return }
        
        //Fetch the movie detail api call
        movieDetailPresenter.movieDetailDelegate = self
        movieDetailPresenter.fetchMovieDetailAPICall(movieId: selectedMovieId)
        
    }
    
    //MARK:- Updating the UI
    private func updateUI(){
        
        movieTitleLabel.accessibilityIdentifier = TestUIElementKeys.movieDetailTitleLabel
        
        self.posterImageView.loadImageUsingUrl(urlString: movieDetailPresenter.posterImageView)
        movieTitleLabel.text = movieDetailPresenter.movieTitle
        movieTagLineLabel.text = movieDetailPresenter.movieTagline
        movieDescription.text = movieDetailPresenter.movieDescription
        movieRuntimeLabel.text = movieDetailPresenter.movieRuntime
        ratingValueLabel.text = movieDetailPresenter.movieVote
        releaseDateLabel.text = movieDetailPresenter.movieReleaseDate
        
    }
    
    //MARK: Show Error
    private func showErrorMessage(){
        
        //Updating the UI on the main thread
        DispatchQueue.main.async {
            
            //Unwrapping the errorResult
            guard let errorResult = self.movieDetailPresenter.errorResult else { return }
            //Fetching the errorMessage
            let errorMessage = Utility.retrieveErrorMessage(errorResult: errorResult)
            
            //Display an alert box with error message
            let controller = UIAlertController(title: Constants.alertBoxHeading,
                                               message: errorMessage,
                                               preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension MovieDetailViewController : MovieDetailDelegate {
    
    //This funciton will update the UI when api call is successful and model contain valid data
    func movieDetailLoadedSuccessfully() {
        updateUI()
    }
    
    //If there is any error while invoking the api service this method will get called
    func movieDetailFailedToLoad() {
        showErrorMessage()
    }
}
