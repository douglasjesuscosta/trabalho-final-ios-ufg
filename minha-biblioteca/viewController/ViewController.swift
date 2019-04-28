//
//  ViewController.swift
//  minha-biblioteca
//
//  Created by Douglas de Jesus Costa on 27/04/19.
//  Copyright © 2019 Douglas de Jesus Costa. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    var customBookCollectionFlowLayout: CustomBookCollectionLayout!
    var books = [Book]()
    
    var dbRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Inicializacao do banco de dados e carregamento de imagens
        dbRef = Database.database().reference().child("books")
        
        //customBookCollectionFlowLayout = CustomBookCollectionLayout()
        //bookCollectionView.collectionViewLayout = customBookCollectionFlowLayout
        
        loadDB()
    }
    
    func loadBooks() {
        
    }
    
    func loadDB() {
        dbRef.observe(DataEventType.value) { (DataSnapshot) in
            var newBooks = [Book]()
            
            for bookSnapshot in DataSnapshot.children {
                let bookObject  = Book(snapshot: bookSnapshot as! DataSnapshot)
                newBooks.append(bookObject)
                print(bookSnapshot)
            }
            
            self.books = newBooks
            self.bookCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
        
        let book = books[indexPath.row]
        
       
        cell.imageBook.sd_setImage(with: URL(string: book.imageUrl))
        cell.titleBook.text = book.name
        
        return cell
    }
}

