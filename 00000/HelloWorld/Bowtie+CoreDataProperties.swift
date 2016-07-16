//
//  Bowtie+CoreDataProperties.swift
//  HelloWorld
//
//  Created by D_ttang on 15/7/22.
//  Copyright © 2015年 D_ttang. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Bowtie {

    @NSManaged var isFavorite: NSNumber?
    @NSManaged var lastWorn: NSDate?
    @NSManaged var name: String?

}
