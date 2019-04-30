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

    func loadDB() {
        dbRef.observe(DataEventType.value) { (DataSnapshot) in
            var newBooks = [Book]()
            
            for bookSnapshot in DataSnapshot.children {
                let bookObject  = Book(snapshot: bookSnapshot as! DataSnapshot)
                newBooks.append(bookObject)
                print(bookSnapshot)
            }
            
            var indexPaths: [NSIndexPath] = []
            for i in 0..<self.bookCollectionView!.numberOfItems(inSection: 0) {
                indexPaths.append(NSIndexPath(item: i, section: 0))
            }
            
            self.books = newBooks
            self.bookCollectionView.reloadData()
            self.bookCollectionView.reloadItems(at: indexPaths as [IndexPath])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
        
        let book = books[indexPath.row]
        
        if cell.titleBook != nil {
            cell.titleBook.text = book.name
            
            if(!book.imageUrl.isEmpty){
                cell.imageBook.sd_setImage(with: URL(string: book.imageUrl))
                return cell
            } else {
                var image = UIImage(named: "book")!
                cell.imageBook = UIImageView(image: image)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let viewControllerViewBook = self.storyboard?.instantiateViewController(withIdentifier: "viewBook") as! ViewBookViewController
        
        viewControllerViewBook.book = books[indexPath.row]
        
        viewControllerViewBook.modalTransitionStyle = .flipHorizontal
        //self.present(viewControllerViewBook, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(viewControllerViewBook, animated: true)

        
    }

}

