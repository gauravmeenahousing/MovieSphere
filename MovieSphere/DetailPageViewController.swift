//
//  DetailPageViewController.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 23/08/23.
//

import UIKit

class DetailPageViewController: UIViewController {
    
    var movieData : MovieData?
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    @IBOutlet weak var PageTitle: UINavigationItem!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    @IBOutlet weak var overViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PageTitle.backBarButtonItem?.title = "Back"
        PageTitle.title = movieData?.title
        releaseLabel.text = movieData?.release_date as? String
        ratingLabel.text = movieData?.vote_average as? String
        popLabel.text = movieData?.popularity as? String
        guard let posterPath = movieData?.poster_path, let imageURL = URL(string : "https://image.tmdb.org/t/p/original\(posterPath)") else {
            return
        }
        moviePosterImage.downloadImage(from: imageURL)
        overViewLabel.text = movieData?.overview
    }
}
