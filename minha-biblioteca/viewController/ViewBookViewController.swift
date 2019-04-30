//
//  ViewBookViewController.swift
//  minha-biblioteca
//
//  Created by Douglas de Jesus Costa and Lucas de Castro Ribeiro on 29/04/19.
//  Copyright © 2019 Douglas de Jesus Costa and Lucas de Castro Ribeiro. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewBookViewController: UIViewController {
    
    var book: Book!
    var dbRef: DatabaseReference!
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var bookDescription: UITextField!
    @IBOutlet weak var bookValue: UITextField!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadBookValues()
        dbRef = Database.database().reference().child("books")
        // Do any additional setup after loading the view.
    }
    
    /*
     Metodo que carrega os dados do livro nos campos
     Tambem e feita a logica de visualizacao da classificacao
    */
    func loadBookValues(){
        if(book != nil){
            bookImage.sd_setImage(with: URL(string: book.imageUrl))
            bookTitle.text = book.name
            bookAuthor.text = book.author
            bookDescription.text = book.bookDescription
            bookValue.text = String(book.value)
        
            if(book.classification == 1){
                star1.isHighlighted = true
            } else if(book.classification == 2){
                star1.isHighlighted = true
                star2.isHighlighted = true
            } else if(book.classification == 3){
                star1.isHighlighted = true
                star2.isHighlighted = true
                star3.isHighlighted = true
            } else if(book.classification == 4){
                star1.isHighlighted = true
                star2.isHighlighted = true
                star3.isHighlighted = true
                star4.isHighlighted = true
            } else {
                star1.isHighlighted = true
                star2.isHighlighted = true
                star3.isHighlighted = true
                star4.isHighlighted = true
                star5.isHighlighted = true
            }
            
        }
    }
    
    
    /*
     Metodo responsavel pela remocao de um livro no Firebase
    */
    @IBAction func deleteBook(_ sender: Any) {
        let reference = self.dbRef.child(book.key)
        
        reference.removeValue { error, _ in
            print(error?.localizedDescription)
        }
    }
}
