//
//  FavoritesViewController.swift
//  Rick And Morty
//
//  Created by Dmitriy Pirko on 08.09.2022.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {
    
    private let signManager = SignManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutButtonAction(_ sender: Any) {
        signManager.signOut()
        dismiss(animated: true, completion: nil)
    }
    
}
