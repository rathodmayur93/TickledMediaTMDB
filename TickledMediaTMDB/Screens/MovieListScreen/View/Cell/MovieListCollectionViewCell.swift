//
//  MovieListCollectionViewCell.swift
//  TickledMedia
//
//  Created by ds-mayur on 2/13/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
   // @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //self.layer.borderWidth = 3.0
        //self.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setupCell(fetchMoviePresenter : FetchMoviePresenter, itemIndex : Int){
        moviePosterImageView.image = nil
        movieNameLabel.text = fetchMoviePresenter.fetchMovieName(atIndex: itemIndex)
        moviePosterImageView.loadImageUsingUrl(urlString: fetchMoviePresenter.fetchMoviePosterUrl(atIndex: itemIndex))
    }
}
