//
//  ViewController.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 22/08/23.
//

import ExtensionKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var searchBar: UINavigationItem!
    @IBOutlet weak var movieTableView: UITableView!
    
    var viewMovie = MovieListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        viewMovie.observerDataChanges { [weak self] in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
        viewMovie.fetchData(url: Constants.URL.apiURL)
        
    }
}
