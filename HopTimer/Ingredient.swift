//
//  Ingredient.swift
//  HopTimer
//
//  Created by Jason Wiles on 2/16/15.
//  Copyright (c) 2015 TallB Studios. All rights reserved.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {

    @NSManaged var desc: String
    @NSManaged var boilTime: NSNumber
    @NSManaged var ingredientType: String
    @NSManaged var recipe: Recipe

    //used when user starts the timer
    var timeRemaining: Int = 0
    var added: Bool = false
    
}
