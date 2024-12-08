//
//  MapViewModel.swift
//  TourchRideMap
//
//  Created by Nikunj Thakur on 2024-12-08.
//

import Foundation
import MapKit

class MapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion

    init() {
        // Default region (TourchRide HQ)
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 29.739017, longitude: -95.774269),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }

    func updateRegion(latitude: Double, longitude: Double) {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
}

