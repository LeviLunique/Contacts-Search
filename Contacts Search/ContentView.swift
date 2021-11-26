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
                SearchBar()
                EmptyStateView()
            }
            .navigationBarTitle("Contact Search")
        }
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
        return SearchBarCoordinator()
    }
        
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: UserListViewModel())
    }
}
