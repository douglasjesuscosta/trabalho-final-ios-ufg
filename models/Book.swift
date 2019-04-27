//
//  Book.swift
//  minha-biblioteca
//
//  Created by Douglas de Jesus Costa on 27/04/19.
//  Copyright © 2019 Douglas de Jesus Costa. All rights reserved.
//

import Foundation

class Book : NSObject, NSCoding {
    
    let name:String
    let author:String
    let classification:Int
    let bookDescription:String
    let value:Float
    
    init(name:String, author:String, classification:Int, bookDescription:String, value:Float) {
        self.name = name
        self.author = author
        self.classification = classification
        self.bookDescription = bookDescription
        self.value = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey : "name") as! String
        self.author = aDecoder.decodeObject(forKey: "author") as! String
        self.classification = aDecoder.decodeInteger(forKey: "classification")
        self.bookDescription = aDecoder.decodeObject(forKey: "bookDescription") as! String
        self.value = aDecoder.decodeObject(forKey: "value") as! Float
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(author, forKey : "author")
        aCoder.encode(classification, forKey : "classification")
        aCoder.encode(bookDescription, forKey: "bookDescription")
        aCoder.encode(value, forKey: "value")
    }
    
}








