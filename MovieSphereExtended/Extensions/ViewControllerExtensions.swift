//
//  ViewControllerExtensions.swift
//  MovieSphereExtended
//
//  Created by Gaurav Meena on 28/08/23.
//

import Foundation
import UIKit
import SkeletonView

extension ViewController : SkeletonTableViewDataSource, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewMovie.filteredData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.movieListCell, for: indexPath) as! MovieListTableViewCell
        cell.nameLabel.text = viewMovie.filteredData[indexPath.row].title
        cell.overViewLabel.text = viewMovie.filteredData[indexPath.row].overview
        let imageURL = URL(string : "\(Constants.URL.imageBaseURL)\(viewMovie.filteredData[indexPath.row].poster_path)")
        cell.imageLabel.sd_setImage(with: imageURL, placeholderImage: UIImage(named: Constants.Defaults.image))
        cell.imageLabel.layer.cornerRadius = 10
        cell.imageLabel.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segue.detailPageSegue, sender: nil)
        movieTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.detailPageSegue, let indexPath = movieTableView.indexPathForSelectedRow , let destinationVC = segue.destination as? DetailPageViewController {
            let selectedMovie = viewMovie.filteredData[indexPath.row]
                destinationVC.movieData = selectedMovie
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewMovie.filteredData = viewMovie.moviesDataList
            nextButton.isHidden = false
        }else {
            viewMovie.filteredData = viewMovie.moviesDataList.filter{ $0.title.contains(searchText)}
            nextButton.isHidden = true
        }
        movieTableView.reloadData()
    }
    
    func setupView() {
        backButton.isHidden = true
        viewMovie.observerDataChanges { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [self] in
                self?.movieTableView.reloadData()
                self?.movieTableView.stopSkeletonAnimation()
                self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            })
        }
        self.viewMovie.fetchData(url: Constants.URL.apiURL+"\(self.page)")
    }
    
    // TODO: Exception handling when the page reach to the last page.
    @IBAction func pressNextButton(_ sender: Any) {
        page = min(page + 1, 88)
        nextButton.isHidden = page == 88
        backButton.isHidden = false
        showSkeletonView()
        self.viewMovie.fetchData(url: Constants.URL.apiURL+"\(self.page)")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        page = max(page - 1, 0)
        backButton.isHidden = page == 1
        showSkeletonView()
        self.viewMovie.fetchData(url: Constants.URL.apiURL+"\(self.page)")
    }
    
    func showSkeletonView() {
        movieTableView.isSkeletonable = true
        movieTableView.showSkeleton(usingColor: .orange, transition: .crossDissolve(0.25))
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return Constants.CellIdentifier.movieListCell
    }
}
