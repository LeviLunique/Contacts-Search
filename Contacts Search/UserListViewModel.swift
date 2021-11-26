//
//  UserListViewModel.swift
//  Contacts Search
//
//  Created by user204006 on 11/25/21.
//
import Combine
import Foundation
import SwiftUI

class UserListViewModel: ObservableObject {
    @Published  var searchTerm: String = ""
    @Published public private(set) var users: [UserViewModel] = []
    
    private let dataModel: DataModel = DataModel()
    private var disposables = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .sink(receiveValue: loadUsers(searchTerm:))
            .store(in: &disposables)
    }
    
    private func loadUsers(searchTerm: String) {
        users.removeAll()
        
        dataModel.getUsers() { users in
            users.forEach{self.appendUser(user: $0)}
        }
    }
    
    private func appendUser(user: User) {
        let userViewModel = UserViewModel(user: user)
        DispatchQueue.main.async {
            self.users.append(userViewModel)
        }
        
    }
    
}

class UserViewModel: Identifiable, ObservableObject {
    let id: Int
    let name, username, email: String
    let phone, website: String
    
    init(user: User) {
        self.id = user.id
        self.name = user.name
        self.username = user.username
        self.email = user.email
        self.phone = user.phone
        self.website = user.website
    }
}
