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
        movieDetailPresenter.fetchMovieDetailAPICall(movieId: selectedMovieId)
        movieDetailPresenter.movieDetailDelegate = self
    }
    
    //MARK:- Updating the UI
    func updateUI(){
        self.posterImageView.loadImageUsingUrl(urlString: movieDetailPresenter.posterImageView)
        movieTitleLabel.text = movieDetailPresenter.movieTitle
        movieTagLineLabel.text = movieDetailPresenter.movieTagline
        movieDescription.text = movieDetailPresenter.movieDescription
        movieRuntimeLabel.text = movieDetailPresenter.movieRuntime
        ratingValueLabel.text = movieDetailPresenter.movieVote
        releaseDateLabel.text = movieDetailPresenter.movieReleaseDate
        
    }
    
    //MARK: Show Error
    func showErrorMessage(){
        let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}

extension MovieDetailViewController : MovieDetailDelegate{
    
    func movieDetailLoadedSuccessfully() {
        updateUI()
    }
    
    func movieDetailFailedToLoad() {
        showErrorMessage()
    }
}
