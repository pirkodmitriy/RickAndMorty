//
//  NetworkManager.swift
//  Rick And Morty
//
//  Created by Dmitriy Pirko on 08.09.2022.
//

import Foundation

class NetworkManager {
    
    private let http = "http://"
    private let baseURL = "api.android-test-app.4-com.pro/v0"
    private let signInEndPoint = "/singin/"
    private let signUpEndPoint = "/singup/"
    private let postEndPoint = "/post/list/"
    
    func signIn(parameters: SignModel, completionHandler: @escaping (_ result: String) -> Void) {
        
        let url = URL(string: http+baseURL+signInEndPoint)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = getSignInModelBody(with: parameters)
        URLSession.shared.dataTask(with: request)  { (data, response, error) in
            
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            if let result = String(data: data, encoding: .utf8) {
                print(result)
                //self.getCookies(request: request) {
                    completionHandler(result)
                //}
            }
            
        }.resume()
    }
    
    func signUp(parameters: SignModel, completionHandler: @escaping (_ result: String) -> Void) {
        
        let url = URL(string: http+baseURL+signUpEndPoint)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = getSignUpModelBody(with: parameters)
        URLSession.shared.dataTask(with: request)  { (data, response, error) in
            
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            if let result = String(data: data, encoding: .utf8) {
                print(result)
                    completionHandler(result)
            }
            
        }.resume()
    }
    
    func loadChatacters(token: String, completionHandler: @escaping (_ result: String) -> Void) {
        let url = URL(string: http+baseURL+postEndPoint)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(token, forHTTPHeaderField: "authorization")
        URLSession.shared.dataTask(with: request)  { (data, response, error) in
            
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            if let result = String(data: data, encoding: .utf8) {
                print(result)
                completionHandler(result)
            }
            
        }.resume()
    }
    
    func getSignInModelBody(with parameters: SignModel) -> Data? {
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(parameters)
        
        
        return jsonData
    }
    
    func getSignUpModelBody(with parameters: SignModel) -> Data? {
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(parameters)
        
        
        return jsonData
    }
    
    func getSignUpModelBody(with parameters: CharactersModel) -> Data? {
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(parameters)
        
        
        return jsonData
    }
    
}
