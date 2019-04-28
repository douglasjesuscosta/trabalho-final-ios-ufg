//
//  AddBookViewController.swift
//  minha-biblioteca
//
//  Created by Douglas de Jesus Costa on 28/04/19.
//  Copyright © 2019 Douglas de Jesus Costa. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {

    @IBOutlet weak var titleBookField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var classificationField: UITextField!
    @IBOutlet weak var bookPhotoField: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addBookPhoto(_ sender: Any) {
    }
    
    @IBAction func saveBook(_ sender: Any) {
    }
    
    @IBAction func cancel(_ sender: Any) {
    }
    
}
