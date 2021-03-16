//
//  Movie.swift
//  MovieApp
//
//  Created by Oufaa on 14/03/2021.
//

import Foundation

class Movie: Codable {
    var title: String
    var image: String
    var rating: Float
    var releaseYear: Int
    let genre: [String]
        
    init(title:String,image:String,rating:Float,realeseYear:Int,genre:[String]) {
      self.title = title
        self.image = image
        self.rating = rating
        self.releaseYear = realeseYear
        self.genre = genre
    }
    enum CodingKeys: String, CodingKey {
         case title = "title"
         case image = "image"
         case rating = "rating"
         case releaseYear = "releaseYear"
         case genre = "genre"

     }
}
