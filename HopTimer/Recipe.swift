//
//  Recipe.swift
//  HopTimer
//
//  Created by Jason Wiles on 2/16/15.
//  Copyright (c) 2015 TallB Studios. All rights reserved.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var notes: String
    @NSManaged var style: String
    @NSManaged var boilTime: NSNumber
    @NSManaged var ingredient: NSSet
    


}
