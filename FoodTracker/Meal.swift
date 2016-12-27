//
//  Meal.swift
//  FoodTracker
//
//  Created by Tacal Tudor on 27/12/2016.
//  Copyright © 2016 Tacal Tudor. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    
    init(name: String, photo: UIImage?, rating: Int) {
    
        //Initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    
    }
}
