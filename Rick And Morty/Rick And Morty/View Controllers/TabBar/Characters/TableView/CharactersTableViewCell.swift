//
//  CharactersTableViewCell.swift
//  Rick And Morty
//
//  Created by Dmitriy Pirko on 10.09.2022.
//

import Foundation
import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var favorite: UIButton!
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        
    }
    
}
