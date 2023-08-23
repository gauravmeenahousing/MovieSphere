//
//  ViewController.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 22/08/23.
//

import UIKit

class ViewController: UIViewController {

    var moviesDataList = [MovieData]()
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    func fetchData() {
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"
        guard let urlString = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlString) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(JSONData.self, from: data)
                    self.moviesDataList = jsonData.results
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                } catch {
                    print("Error occured while decoding JSON : \(error)")
                }
            }
        }
        task.resume()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesDataList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieListTableViewCell
        cell.nameLabel.text = moviesDataList[indexPath.row].title
        cell.overViewLabel.text = moviesDataList[indexPath.row].overview
        let imageURL = URL(string : "https://image.tmdb.org/t/p/original\(moviesDataList[indexPath.row].poster_path)")
        cell.ImageLabel.downloadImage(from: imageURL!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailPageSegue", sender: nil)
        movieTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPageSegue", let indexPath = movieTableView.indexPathForSelectedRow , let destinationVC = segue.destination as? DetailPageViewController {
                let selectedMovie = moviesDataList[indexPath.row]
                destinationVC.movieData = selectedMovie
        }
    }
    
}

