//
//  MovieListView.swift
//  MovieSphereExtended
//
//  Created by Gaurav Meena on 29/08/23.
//

import Foundation

class MovieListView {
    
    var moviesDataList = [MovieData]()
    var filteredData   = [MovieData]()
    
    private var observers : [() -> Void] = [] // observer instance 
    
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
                    self.notifyObservers()
                } catch {
                    print("Error occured while decoding JSON : \(error)")
                }
            }
        }
    }
}
