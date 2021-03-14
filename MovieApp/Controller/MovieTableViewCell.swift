//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Oufaa on 14/03/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var moviesImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
