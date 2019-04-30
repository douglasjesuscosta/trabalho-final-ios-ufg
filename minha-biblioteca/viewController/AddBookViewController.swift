//
//  AddBookViewController.swift
//  minha-biblioteca
//
//  Created by Douglas de Jesus Costa on 28/04/19.
//  Copyright © 2019 Douglas de Jesus Costa. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class AddBookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleBookField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var classificationField: UITextField!
    @IBOutlet weak var photoBookField: UIImageView!
    
    @IBOutlet weak var valueField: UITextField!
    
    private let imagePicker = UIImagePickerController()
    private var dbRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
         dbRef = Database.database().reference().child("books")
    }
    
    /*
     Método para escolher foto da galeria para realizar o upload
    */
    @IBAction func addBookPhoto(_ sender: Any) {
        /*self.imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        */
        present(imagePicker, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /*
     Funcao acionada apos a finalizacao da escolha da imagem pelo usuario. E feita a atribuicao da imagem selecionada a imagemview na tela.
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            photoBookField.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    /*
     Metodo acionado a partir do botao "Salvar" inicializando o fluxo de persistencia de um livro
    */
    func persistBook(imageUrl: String) {
    
        let name = titleBookField.text as! String
        let author = authorField.text as! String
        let description = descriptionField.text as! String
        let classification = Int(classificationField.text!)
        let value = Float(valueField.text!)
        
        let book:Book = Book(name: name, author: author, classification: classification!, bookDescription: description, value: value!, imageUrl: imageUrl)
        
        let key = dbRef.childByAutoId().key
        book.key = key!
        
        let childUpdates = ["/\(key)":book.nsDictionary]
        
        self.dbRef.updateChildValues(childUpdates)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    * Metodo para realizar a persistencia do livro no Firebase.
    */
    
    @IBAction func saveBook(_ sender: Any) {
    
        if (photoBookField.image != nil) {
            
            if let imageData = photoBookField.image?.jpegData(compressionQuality: 0.3) {
                let imageId = randomString(length: 10)
                let storageRef = Storage.storage().reference().child("images/" + imageId)
                
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpeg"
                
                storageRef.putData(imageData, metadata: metaData) { (metadata, error) in
                        if(error == nil) {
                            storageRef.downloadURL(completion: {(url, error) in
                            let imageUrl = url!.absoluteString
                            self.persistBook(imageUrl: imageUrl)
                        }
                    )}
                 }
            }
            
        }
    }
    
    /*
     Metodo para gerar uma string randomica para nomeacao de imagens
    */
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

