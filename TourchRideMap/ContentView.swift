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

    var body: some View {
        Map(coordinateRegion: $viewModel.region)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                viewModel.requestLocation()
            }
    }
}


#Preview {
    ContentView()
}
