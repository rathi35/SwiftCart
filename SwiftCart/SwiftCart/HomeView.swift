//
//  HomeView.swift
//  SwiftCart
//
//  Created by Rathi Shetty on 11/04/25.
//
import SwiftUI

struct HomeView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    // 📍 Location Display
                    Text("📍 \(locationManager.locationName)")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // 🔍 Searchable List
                    List {
                        ForEach(filteredItems, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .searchable(text: $searchText, prompt: "Search products...")
                }
            }
        }
    }

    // Sample data + filter logic
    let allItems = ["iPhone", "MacBook", "iPad", "AirPods", "Watch"]

    var filteredItems: [String] {
        searchText.isEmpty ? allItems : allItems.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }
}
