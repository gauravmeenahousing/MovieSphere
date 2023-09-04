//
//  ViewController.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 22/08/23.
//

import ExtensionKit
import UIKit
import SkeletonView

class ViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var searchBar: UINavigationItem!
    @IBOutlet weak var movieTableView: UITableView!
    var page = 1
    var viewMovie = MovieListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.isHidden = true
        setupView()
    }
}
