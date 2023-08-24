//
//  ViewController.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 22/08/23.
//

import UIKit

class ViewController: UIViewController {

    private var moviesDataList = [MovieData]()
    
    @IBOutlet private weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    func fetchData() {
        let url = Constants.URL.apiURL
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
        let cell = movieTableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.movieListCell, for: indexPath) as! MovieListTableViewCell
        cell.nameLabel.text = moviesDataList[indexPath.row].title
        cell.overViewLabel.text = moviesDataList[indexPath.row].overview
        let imageURL = URL(string : "\(Constants.URL.imageBaseURL)\(moviesDataList[indexPath.row].poster_path)")
        cell.ImageLabel.downloadImage(from: imageURL!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segue.detailPageSegue, sender: nil)
        movieTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.detailPageSegue, let indexPath = movieTableView.indexPathForSelectedRow , let destinationVC = segue.destination as? DetailPageViewController {
                let selectedMovie = moviesDataList[indexPath.row]
                destinationVC.movieData = selectedMovie
        }
    }
    
}

