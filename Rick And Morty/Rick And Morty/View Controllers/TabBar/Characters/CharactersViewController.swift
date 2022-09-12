//
//  CharactersViewController.swift
//  Rick And Morty
//
//  Created by Dmitriy Pirko on 08.09.2022.
//

import Foundation
import UIKit

class CharactersViewController: UIViewController {
    
    private let signManager = SignManager()
    private let tableView = UITableView()
    private let networkManager = NetworkManager()
    var charactersData: [CharactersModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCharacters()
        setupTableView()
    }
    
    private func loadCharacters() {
        networkManager.loadChatacters(token: signManager.getToken()) { result in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try! decoder.decode(CharactersJSON.self, from: Data(result.utf8))
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func signOutButtonAction(_ sender: Any) {
        signManager.signOut()
        dismiss(animated: true) {
            
        }
    }
    
}
