//
//  ContentView.swift
//  TourchRideMap
//
//  Created by Nikunj Thakur on 2024-12-08.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var searchText = ""

    var body: some View {
        VStack {
            // Search Bar
            HStack {
                TextField("Search for a location", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Button(action: {
                    viewModel.searchLocation(query: searchText)
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding()
                }
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()

            // Show Error Message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            // Recent Searches
            if !viewModel.recentSearches.isEmpty {
                VStack(alignment: .leading) {
                    Text("Recent Searches")
                        .font(.headline)
                        .padding(.horizontal)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.recentSearches, id: \.self) { search in
                                Button(action: {
                                    searchText = search
                                    viewModel.searchLocation(query: search)
                                }) {
                                    Text(search)
                                        .padding(10)
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(5)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }

            // Map View
            Map(coordinateRegion: $viewModel.region)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            viewModel.requestLocation()
        }
    }
}




#Preview {
    ContentView()
}
