//
//  ViewController.swift
//  minha-biblioteca
//
//  Created by Douglas de Jesus Costa on 27/04/19.
//  Copyright © 2019 Douglas de Jesus Costa. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    var customBookCollectionFlowLayout: CustomBookCollectionLayout!
    var books = [Book]()
    
    var dbRef: DatabaseReference!
    
    func loadBooks() {
        
    }
    
    func loadDB() {
        dbRef.observe(DataEventType.value) { (DataSnapshot) in
            var newBooks = [Book]()
            
            for bookSnapshot in DataSnapshot.children {
                let bookObject  = Book(snapshot: bookSnapshot as! DataSnapshot)
                newBooks.append(bookObject)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: <#T##IndexPath#>) as! BookCollectionViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

