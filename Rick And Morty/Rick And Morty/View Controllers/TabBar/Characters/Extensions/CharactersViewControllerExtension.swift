//
//  CharactersViewControllerExtension.swift
//  Rick And Morty
//
//  Created by Dmitriy Pirko on 10.09.2022.
//

import Foundation
import UIKit

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell() as! CharactersTableViewCell
        return cell
    }
    
}
