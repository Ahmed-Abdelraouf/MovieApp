//
//  MovieCoreData+CoreDataProperties.swift
//  
//
//  Created by Oufaa on 15/03/2021.
//
//

import Foundation
import CoreData


extension MovieCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCoreData> {
        return NSFetchRequest<MovieCoreData>(entityName: "MovieCoreData")
    }

    @NSManaged public var genre: [String]?
    @NSManaged public var image: String?
    @NSManaged public var rating: Float
    @NSManaged public var releaseYear: Int32
    @NSManaged public var title: String?
   
}

