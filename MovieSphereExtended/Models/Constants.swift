//
//  Constants.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 24/08/23.
//

import Foundation

struct Constants {
    
    struct URL {
        static let apiURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=3"
        static let imageBaseURL = "https://image.tmdb.org/t/p/original"
    }
    
    struct Segue {
        static let detailPageSegue = "detailPageSegue"
    }
    
    struct CellIdentifier {
        static let movieListCell = "cell"
    }
    
    struct Defaults {
        static let image = "photo.circle"
    }
}
