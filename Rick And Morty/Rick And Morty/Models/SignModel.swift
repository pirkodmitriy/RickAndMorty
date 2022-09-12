//
//  SignInModel.swift
//  Rick And Morty
//
//  Created by Dmitriy Pirko on 08.09.2022.
//

import Foundation

struct SignModel: Codable {
    
    var email: String
    var password: String
    
}

struct SignJSON: Decodable {
    
    var email: [String]?
    var password: [String]?
    var token: String?
    
}
