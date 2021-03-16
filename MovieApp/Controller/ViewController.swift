//
//  ViewController.swift
//  MovieApp
//
//  Created by Oufaa on 14/03/2021.
//

import UIKit
import SDWebImage
import Reachability
import CoreData
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AddProtocol {
    var movies = [Movie]()
    var movieArray = [NSManagedObject]()
    let reachability = try! Reachability()
    var checkData:Bool?
    
    @IBOutlet weak var MovieTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        MovieTableView.delegate = self
        MovieTableView.dataSource = self
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                self.dataRequest()
                self.coreFetch()
                self.checkData = true
                print("Reachable via WiFi")
            } else {
                self.checkData = true
                self.dataRequest()
                self.coreFetch()
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            self.checkData = false
            self.coreFetch()
            self.MovieTableView.reloadData()
            print("unreachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
     
    }

    @IBAction func addButton(_ sender: Any) {
        let add = self.storyboard?.instantiateViewController(identifier: "addVC") as! AddViewController
        add.addProtocol = self
           navigationController?.pushViewController( add, animated: true)
        
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkData == false {
          return  movieArray.count
        }else{
            return movies.count
        }
//    return  movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableView.dequeueReusableCell(withIdentifier: "MovieCell") as!MovieTableViewCell
        if checkData == false {
            cell.moviesImageView.sd_setImage(with: URL(string: movieArray[indexPath.row].value(forKey: "image") as! String), placeholderImage: #imageLiteral(resourceName: "20577349.jpg"))

            cell.NameLabel.text = movieArray[indexPath.row].value(forKey: "title") as? String
        }else{
            cell.moviesImageView.sd_setImage(with: URL(string: movies[indexPath.row].image), placeholderImage: #imageLiteral(resourceName: "20577349.jpg"))
            cell.NameLabel.text = movies[indexPath.row].title
        }
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(identifier: "detailsVC") as! DetailsViewController
        if checkData == true {
            let selctedMovie = movies[indexPath.row]
            _ = UIStoryboard(name: "Main", bundle: nil)
          
            details.movie = selctedMovie
               navigationController?.pushViewController( details, animated: true)
         
        }else{
            let selctedMovie = movieArray[indexPath.row]
            _ = UIStoryboard(name: "Main", bundle: nil)
          
            details.movieCoreData = selctedMovie
               navigationController?.pushViewController( details, animated: true)
         
        }
     

    }

}

extension ViewController {
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
//                self.movies = jesonArray
                for item in jesonArray
                {
                    self.movies.append(Movie(title: item.title , image: item.image, rating: item.rating, realeseYear: item.releaseYear, genre: item.genre ))
                }

                DispatchQueue.main.async {
                    
                    self.MovieTableView.reloadData()
                }
            }catch let error{
                print(error)
            }
        }
        task.resume()
    }
    //------------------------------------------
    func coreSaved(movie:Movie) {
    
      
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let manageContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieCoreData", in: manageContext)
        let moviesCoreData = NSManagedObject(entity: entity!, insertInto: manageContext)


//        for item in movies {
//            moviesCoreData.setValue(item.title, forKey: "title")
//            moviesCoreData.setValue(item.image, forKey: "image")
//            moviesCoreData.setValue(item.rating, forKey: "rating")
//            moviesCoreData.setValue(item.releaseYear, forKey: "releaseYear")
//            let seperating = item.genre.joined(separator: ",")
//            moviesCoreData.setValue(seperating, forKey: "genre")
//        }
        moviesCoreData.setValue(movie.title, forKey: "title")
        moviesCoreData.setValue(movie.image, forKey: "image")
        moviesCoreData.setValue(movie.rating, forKey: "rating")
        moviesCoreData.setValue(movie.releaseYear, forKey: "releaseYear")
//        let seperating = movie.genre.joined(separator: ",")
        moviesCoreData.setValue(movie.genre, forKey: "genre")
        do{
            try manageContext.save()
            movieArray.append(moviesCoreData)
            movies.append(Movie (title: moviesCoreData.value(forKey: "title") as! String , image: moviesCoreData.value(forKey: "image") as! String, rating: moviesCoreData.value(forKey: "rating") as! Float, realeseYear: moviesCoreData.value(forKey: "releaseYear" ) as! Int, genre: moviesCoreData.value(forKey: "genre") as! [String]))
//            movies?.append(moviesCoreData)
        }catch let error{
            print(error)
        }
//        self.MovieTableView.reloadData()
    }
    func coreFetch() {
        
//        var movieManged = [MovieCoreData]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
      
        var movieManged = [MovieCoreData]()
        let fetchRequest = NSFetchRequest<MovieCoreData>(entityName: "MovieCoreData")
        do{
          
            movieManged = try manageContext.fetch(fetchRequest)
            for item in movieManged
            {
//                let arrayOfLetters = [item.genre.map(String.init)]
                var itemGenre:[String]?
                if let val = item.value(forKey: "genre") {
                    itemGenre = ((val as AnyObject) as! [String])
                }
                movies.append(Movie(title: item.value(forKey: "title") as! String , image: item.value(forKey: "image") as! String, rating: item.value(forKey: "rating") as! Float, realeseYear: item.value(forKey: "releaseYear" ) as! Int, genre: itemGenre ?? ["error"]))

//                movies.append(Movie(title: item.value(forKey: "title") as! String , image: item.value(forKey: "image") as! String, rating: item.value(forKey: "rating") as! Float, realeseYear: item.value(forKey: "releaseYear" ) as! Int, genre: item.value(forKey: "genra") as! [String]))
 //
            }
            movieArray =  movieManged
//            movies! += movieArray
        }catch let error{
            print(error)
        }
//        MovieTableView.reloadData()
    }
    func saveMethod(movie: Movie) {
//        movies.append(movie)
        coreSaved(movie: movie)
        MovieTableView.reloadData()
    }

}
//https://images-na.ssl-images-amazon.com/images/I/71IH5WQD5wL._SY679_.jpg
