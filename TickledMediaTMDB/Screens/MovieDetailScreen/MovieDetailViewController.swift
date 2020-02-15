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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let selectedMovieId = movieId else { return }
        
        FetchMovieDetailService.shared.fethcMovieDetail(movieId: selectedMovieId, parameter: ServiceParameters.movieDetailParams()) { (result) in
            switch result{
            case .success(let movieDetail):
                print("Movie Detail ✅ \(movieDetail)")
                DispatchQueue.main.async {
                    self.movieDetailModel = movieDetail
                    self.updateUI()
                }
            case .failure(let error):
                print("Movie Detail ❌ \(error)")
            }
        }
    }
    
    //MARK:- Updating the UI
    func updateUI(){
        self.posterImageView.loadImageUsingUrl(urlString: Constants.imageBaseUrl + (movieDetailModel?.backdropPath ?? ""))
        movieTitleLabel.text = (movieDetailModel?.title ?? "")
        movieTagLineLabel.text = movieDetailModel?.tagline
        movieDescription.text = movieDetailModel?.overview
        movieRuntimeLabel.text = "\(movieDetailModel?.runtime ?? 0)"
        ratingValueLabel.text = "\(movieDetailModel?.voteAverage ?? 0)/10"
        releaseDateLabel.text = movieDetailModel?.releaseDate ?? ""
    }

}
