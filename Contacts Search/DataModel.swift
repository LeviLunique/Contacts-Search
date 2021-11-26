//
//  DataModel.swift
//  Contacts Search
//
//  Created by user204006 on 11/25/21.
//

import Foundation

class DataModel {
    
    func getUsers(completion: @escaping ([User]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let users = try! JSONDecoder().decode([User].self, from: data!)
            
            DispatchQueue.main.async {
                completion(users)
            }
            
        }
        .resume()
    }
    
}

struct User: Codable, Identifiable {
    let id: Int
    let name, username, email: String
    let phone, website: String
}
