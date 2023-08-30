//
//  DetailPageViewController.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 23/08/23.
//

import UIKit
import SDWebImage

class DetailPageViewController: UIViewController {
    
    var movieData : MovieData?
    
    
    @IBOutlet private weak var moviePosterImage: UIImageView!
    
    @IBOutlet private weak var PageTitle: UINavigationItem!
    @IBOutlet private weak var popLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var releaseLabel: UILabel!
    
    @IBOutlet private weak var overViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        guard let movie = movieData else {
            return
        }
        PageTitle.title = movie.title
        releaseLabel.text = movie.release_date
        ratingLabel.text = "\(movie.vote_average)"
        popLabel.text = "\(movie.popularity)"
        let posterPath = movie.poster_path
        let imageURL = URL(string : "\(Constants.URL.imageBaseURL)\(posterPath)")
        moviePosterImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: Constants.Defaults.image))
        moviePosterImage.layer.cornerRadius = 10
        moviePosterImage.clipsToBounds = true
        overViewLabel.text = movie.overview
    }
}
