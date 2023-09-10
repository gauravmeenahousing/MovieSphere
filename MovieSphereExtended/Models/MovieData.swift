//
//  MovieData.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 22/08/23.
//

// Liskov Substitution Principal : In the "ViewController", We have used "MovieData" as a uniform, i.e. we can further add other
//                                 functionalities and it'll not affect the ViewController.

import Foundation

struct MovieData : Codable {
    let title : String            // Name of the movie
    let overview : String         // Overview
    let vote_average : Double     // Rating
    let release_date : String     // Year Of release
    let popularity : Double       // Popularity
    let poster_path : String      // Path of the image
}

struct JSONData : Codable {
    let results : [MovieData]
}
