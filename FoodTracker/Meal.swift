//
//  Meal.swift
//  FoodTracker
//
//  Created by Tacal Tudor on 27/12/2016.
//  Copyright © 2016 Tacal Tudor. All rights reserved.
//

import UIKit
import os.log


class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    
    //Mark: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    encode(with aCoder: NSCoder)
    required convenience init?(coder aDecoder: NSCoder) {
        //The name is required. If we cannot decode a name string, the intializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else {
                os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
                return nil
        }
        //Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey:PropertyKey.rating)
        
        //MUst call designated initializer.\
        self.init(name: name, photo: photo, rating: rating)
    }
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
    
        //The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        //The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        
        //Initialize stored properties
        
        self.name = name
        self.photo = photo
        self.rating = rating
    
    }
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        
    }
}
