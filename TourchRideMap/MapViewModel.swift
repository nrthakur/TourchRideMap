//
//  MapViewModel.swift
//  TourchRideMap
//
//  Created by Nikunj Thakur on 2024-12-08.
//

import Foundation
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region: MKCoordinateRegion
    @Published var errorMessage: String? = nil // For error handling
    @Published var recentSearches: [String] = [] // Store recent searches
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    override init() {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 29.739017, longitude: -95.774269),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }

    func searchLocation(query: String) {
        geocoder.geocodeAddressString(query) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessage = "Error geocoding: \(error.localizedDescription)"
                return
            }
            guard let coordinate = placemarks?.first?.location?.coordinate else {
                self.errorMessage = "No location found for '\(query)'"
                return
            }
            DispatchQueue.main.async {
                self.errorMessage = nil // Clear any previous error
                self.region = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                self.addRecentSearch(query)
            }
        }
    }
    
    // Add the search query to recent searches
    func addRecentSearch(_ query: String) {
        if !recentSearches.contains(query) {
            recentSearches.insert(query, at: 0)
        }
        // Limit to the last 5 searches
        if recentSearches.count > 5 {
            recentSearches.removeLast()
        }
    }
}
