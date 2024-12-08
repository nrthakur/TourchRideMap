//
//  ContentView.swift
//  TourchRideMap
//
//  Created by Nikunj Thakur on 2024-12-08.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 29.739017, longitude: -95.774269), // TourchRide HQ
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all) // Makes the map full screen
    }
}


#Preview {
    ContentView()
}
