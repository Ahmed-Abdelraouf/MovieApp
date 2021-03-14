//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Oufaa on 14/03/2021.
//

import UIKit


class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var movieImageView: UIImageView!

    @IBOutlet weak var ratingLabel: UILabel!

    @IBOutlet weak var realseLabel: UILabel!

    @IBOutlet weak var genreLabel: UILabel!
    
    var movie:Movie?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            titleLabel.text = movie.title
            movieImageView.sd_setImage(with: URL(string: movie.image), placeholderImage: #imageLiteral(resourceName: "20577349.jpg"))
            ratingLabel.text = "\(movie.rating)"
            realseLabel.text = "\(movie.releaseYear)"
            genreLabel.text =  movie.genre.joined(separator: ",")
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
