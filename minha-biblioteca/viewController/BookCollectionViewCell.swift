//
//  BookCollectionViewCell.swift
//  minha-biblioteca
//
//  Created by Douglas de Jesus Costa and Lucas de Castro Ribeiro on 27/04/19.
//  Copyright © 2019 Douglas de Jesus Costa and Lucas de Castro Ribeiro. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var titleBook: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse();
        self.imageBook = nil
        self.titleBook = nil
    }
    
}
