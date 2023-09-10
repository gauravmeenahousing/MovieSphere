//
//  NetworkManager.swift
//  MovieSphereExtended
//
//  Created by Gaurav Meena on 30/08/23.
//


// SRP Principal -> NetWork Manager has only one task : To fetch data from the server URL.

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {} // Ensure the Singleton pattern : Since no other instance can be created outside this class.
    
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
