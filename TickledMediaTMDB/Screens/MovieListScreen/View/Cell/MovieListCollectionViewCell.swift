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
    
    var imageCache = [String : UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //self.layer.borderWidth = 3.0
        //self.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setupCell(fetchMoviePresenter : FetchMoviePresenter, itemIndex : Int){
        moviePosterImageView.image = nil
        movieNameLabel.text = fetchMoviePresenter.fetchMovieName(atIndex: itemIndex)
        
        if let image = imageCache[fetchMoviePresenter.fetchMoviePosterUrl(atIndex: itemIndex)]{
            moviePosterImageView.image = image
        }else{
            moviePosterImageView.loadImageUsingUrl(urlString: fetchMoviePresenter.fetchMoviePosterUrl(atIndex: itemIndex))
            imageCache[fetchMoviePresenter.fetchMoviePosterUrl(atIndex: itemIndex)] = moviePosterImageView.image
        }
    }
}
