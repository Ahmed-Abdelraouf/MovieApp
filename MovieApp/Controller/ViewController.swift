//
//  ViewController.swift
//  MovieApp
//
//  Created by Oufaa on 14/03/2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AddProtocol {
    var movies = [Movie]()

    func saveMethod(movie: Movie) {
        movies.append(movie)
        MovieTableView.reloadData()
    }
    
    
    @IBOutlet weak var MovieTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        MovieTableView.delegate = self
        MovieTableView.dataSource = self
        dataRequest()
    }

    @IBAction func addButton(_ sender: Any) {
        let add = self.storyboard?.instantiateViewController(identifier: "addVC") as! AddViewController
        add.addProtocol = self
           navigationController?.pushViewController( add, animated: true)
        
    }
    
    func dataRequest() {
        
        let url = URL(string: "https://api.androidhive.info/json/movies.json")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
 
        let task = session.dataTask(with: request) { (data, response, error) in
            do{
//                print(String(data: data!, encoding: .utf8)!)
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jesonArray = try decoder.decode([Movie].self, from: data!)
                self.movies = jesonArray
                DispatchQueue.main.async {
                    
                    self.MovieTableView.reloadData()
                }
            }catch let error{
                print(error)
            }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = MovieTableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        let cell = MovieTableView.dequeueReusableCell(withIdentifier: "MovieCell") as!MovieTableViewCell
            cell.moviesImageView.sd_setImage(with: URL(string: movies[indexPath.row].image), placeholderImage: #imageLiteral(resourceName: "20577349.jpg"))

        cell.NameLabel.text = movies[indexPath.row].title
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(identifier: "detailsVC") as! DetailsViewController
        let selctedMovie = movies[indexPath.row]
        _ = UIStoryboard(name: "Main", bundle: nil)
      
        details.movie = selctedMovie
           navigationController?.pushViewController( details, animated: true)
     

    }

}

