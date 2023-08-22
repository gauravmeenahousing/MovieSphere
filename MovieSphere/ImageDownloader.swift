//
//  ImageDownloader.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 22/08/23.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from url : URL) {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let http = response as? HTTPURLResponse, http.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else {
                print("Error while downloading the image from URL")
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
        dataTask.resume()
    }
}
