//
//  MovieListView.swift
//  MovieSphereExtended
//
//  Created by Gaurav Meena on 29/08/23.
//

// Single Responsiblity Principal : Managing movie data and modifying observers
// Open/Closed Principal : conforms the "MovieListViewProvider" protocol

import Foundation


protocol MovieListViewProvider {
    var moviesDataList : [MovieData] { get set }
    var filteredData : [MovieData] {get set}
    func fetchData(url : String)
    func observerDataChanges(observer: @escaping () -> Void)
}

class MovieListView : MovieListViewProvider {
    
    var moviesDataList = [MovieData]()
    var filteredData   = [MovieData]() {
        didSet {
            notifyObservers() // observer instance
        }
    }
    
    private var observers : [() -> Void] = []
    
    func observerDataChanges(observer: @escaping () -> Void) {
        observers.append(observer)
    }
    
    func notifyObservers() {
        observers.forEach { observer in
            observer()
        }
    }
    
    func fetchData(url : String) {
        NetworkManager.shared.fetchData(from: url) { data, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(JSONData.self, from: data)
                    self.moviesDataList = jsonData.results
                    self.filteredData = self.moviesDataList
                } catch {
                    print("Error occured while decoding JSON : \(error)")
                }
            }
        }
    }
}
