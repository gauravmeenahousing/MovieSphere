//
//  NetworkManager.swift
//  MovieSphereExtended
//
//  Created by Gaurav Meena on 30/08/23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager() // Singleton instance
    
    func fetchData(from url : String, completion : @escaping (Data?, Error?) -> Void) {
        guard let urlString = URL(string: url) else {
            // If an error occured then give Invalid URL error
            let error = NSError(domain: "Invalid URL", code: 0)
            completion(nil, error)
            return
        }
        let task = URLSession.shared.dataTask(with: urlString) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }
}
