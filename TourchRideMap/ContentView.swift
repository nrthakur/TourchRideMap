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
                    .onChange(of: searchText) { newValue in
                        viewModel.fetchSuggestions(query: newValue)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    viewModel.searchLocation(query: searchText)
                    searchText = ""  // Clear the text field after search
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

            // Address Suggestions
            if !viewModel.addressSuggestions.isEmpty && searchText != "" {
                VStack(alignment: .leading) {
                    Text("Suggestions")
                        .font(.headline)
                        .padding(.horizontal)
                    List(viewModel.addressSuggestions, id: \.self) { suggestion in
                        Button(action: {
                            searchText = suggestion
                            viewModel.searchLocation(query: suggestion)
                            viewModel.addressSuggestions = []  // Hide suggestions after selection
                        }) {
                            Text(suggestion)
                                .padding()
                        }
                    }
                    .frame(maxHeight: 65)  // Limit height of suggestions list
                    .listStyle(PlainListStyle()) // Simplify list style
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

