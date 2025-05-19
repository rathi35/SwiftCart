//
//  MainTabView.swift
//  SwiftCart
//
//  Created by Rathi Shetty on 11/04/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            CategoriesView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Categories")
                }

            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
        .accentColor(.purple)
    }
}




struct CategoriesView: View {
    var body: some View {
        NavigationView {
            Text("All Categories")
                .navigationTitle("Categories")
        }
    }
}

struct CartView: View {
    var body: some View {
        NavigationView {
            Text("Your Cart")
                .navigationTitle("Cart")
        }
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationView {
            Text("Your Profile")
                .navigationTitle("Profile")
        }
    }
}
