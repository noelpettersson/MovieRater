//
//  ContentView.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-07-27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabView {
                    MainView()
                        .tabItem() {
                            Image(systemName: "person")
                            Text("Profile")
                        }
                    
                    MovieTopRatedView()
                        .tabItem() {
                            Image(systemName: "film")
                            Text("Main")
                        }
                    
                    MovieSearchView()
                        .tabItem() {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    
                    
                }
            } else {
                RegisterView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
