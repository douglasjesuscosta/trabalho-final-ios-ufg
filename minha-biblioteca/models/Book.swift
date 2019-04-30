//
//  Book.swift
//  minha-biblioteca
//
//  Created by Douglas de Jesus Costa on 27/04/19.
//  Copyright © 2019 Douglas de Jesus Costa. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Book : NSObject, NSCoding {
    
    var key:String
    var name:String
    var author:String
    var classification:Int
    var bookDescription:String
    var value:Float
    var imageUrl:String
    
    var itemRef: DatabaseReference?
    
    var dictionary: [String:Any] {
        return ["key":key,
                "name":name,
                "author":author,
                "classification":classification,
                "bookDescription":bookDescription,
                "value":value,
                "imageUrl":imageUrl
                ]
    }
    
    init(name:String, author:String, classification:Int, bookDescription:String, value:Float, imageUrl:String) {
        self.key = ""
        self.name = name
        self.author = author
        self.classification = classification
        self.bookDescription = bookDescription
        self.value = value
        self.imageUrl = imageUrl
        
        self.itemRef = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.key = aDecoder.decodeObject(forKey: "key") as! String
        self.name = aDecoder.decodeObject(forKey : "name") as! String
        self.author = aDecoder.decodeObject(forKey: "author") as! String
        self.classification = aDecoder.decodeInteger(forKey: "classification")
        self.bookDescription = aDecoder.decodeObject(forKey: "bookDescription") as! String
        self.value = aDecoder.decodeObject(forKey: "value") as! Float
        self.imageUrl = aDecoder.decodeObject(forKey: "imageUrl") as! String
        
        self.itemRef = nil
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(key, forKey: "key")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(author, forKey : "author")
        aCoder.encode(classification, forKey : "classification")
        aCoder.encode(bookDescription, forKey: "bookDescription")
        aCoder.encode(value, forKey: "value")
        aCoder.encode(imageUrl, forKey: "imageUrl")
        aCoder.encode(itemRef, forKey: "itemRef")
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let name = snapshotValue?["name"] as? String {
            self.name = name
        } else{
            self.name = ""
        }
        
        if let author = snapshotValue?["author"] as? String {
            self.author = author
        } else{
            self.author = ""
        }
        
        if let classification = snapshotValue?["classification"] as? Int {
            self.classification = classification
        } else{
            self.classification = 0
        }
        
        if let bookDescription = snapshotValue?["bookDescription"] as? String {
            self.bookDescription = bookDescription
        } else{
            self.bookDescription = ""
        }
        
        if let value = snapshotValue?["value"] as? Float {
            self.value = value
        } else{
            self.value = 0
        }
        
        if let imageUrl = snapshotValue?["imageUrl"] as? String {
            self.imageUrl = imageUrl
        } else{
            self.imageUrl = ""
        }
        
        if let key = snapshotValue?["key"] as? String {
            self.key = key
        } else{
            self.key = ""
        }
    }
    
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
    
}








