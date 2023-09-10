//
//  ViewController.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 22/08/23.
//

import ExtensionKit
import UIKit
import SkeletonView

// Interface Segregation Principal : The client as in "ViewController" is using the "MovieListView" instance, which conforms to
//                                   "MovieListViewProvider" protocol. That means It uses all functionalities that it conforms to.

// Dependency Inversion Principal : "ViewController" now does not rely on any random implementation, but relies on the abstraction
//                                  provided by the "MovieListViewProvider" protocol.

class ViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var searchBar: UINavigationItem!
    @IBOutlet weak var movieTableView: UITableView!
    var page = 1
    var viewMovie : MovieListViewProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMovie = MovieListView()
        setupView()
    }
}
