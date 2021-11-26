//
//  ContentView.swift
//  Contacts Search
//
//  Created by user204006 on 11/25/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchTerm: $viewModel.searchTerm)
                if viewModel.users.isEmpty {
                    EmptyStateView()
                } else {
                    List(viewModel.users) { user in
                        UserView(user: user)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Contact Search")
        }
    }
}

struct UserView: View {
    
    @ObservedObject var user: UserViewModel
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(user.name)
                Text(user.phone)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
    
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Start searching for contact...")
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(Color(.systemIndigo))
    }
}
    
struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    @Binding var searchTerm: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Type a user name, email or phone..."
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
        
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searchTerm: $searchTerm)
    }
        
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchTerm: String
        
        init(searchTerm: Binding<String>) {
            self._searchTerm = searchTerm
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: UserListViewModel())
    }
}
