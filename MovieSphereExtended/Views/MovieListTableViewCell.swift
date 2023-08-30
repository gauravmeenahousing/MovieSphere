//
//  MovieListTableViewCell.swift
//  MovieSphere
//
//  Created by Gaurav Meena on 22/08/23.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
