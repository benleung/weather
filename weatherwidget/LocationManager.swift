//
//  LocationManager.swift
//  weather
//
//  Created by Ben Leung on 2022/05/15.
//

import Foundation
import CoreLocation

// FIXME: need refactoring
public class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    private let nc = NotificationCenter.default // FIXME: unnecessary
    
    @Published var authStatus: CLAuthorizationStatus?
    @Published var gpsLocation: CLLocationCoordinate2D?  // nil if not authorized for Location
    
    public override init() {
        super.init()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestAlwaysAuthorization()
        self.manager.startUpdatingLocation()
        self.authStatus = self.manager.authorizationStatus
    }

    public func update() {
        fetchCurrentCoordinates()
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // FIXME: use switch instead
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            fetchCurrentCoordinates()
            nc.post(name: Notification.Name("ChangedLocation"), object: nil)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if (location.distance(from: CLLocation(latitude: (gpsLocation?.latitude ?? 52.01), longitude: (gpsLocation?.longitude ?? 10.77))) > 2500) { // if distance change > 2.5 km
                self.gpsLocation = location.coordinate
                nc.post(name: Notification.Name("ChangedLocation"), object: nil) // notify view
            }
        }
    }
    
    private func fetchCurrentCoordinates() {
        self.authStatus = self.manager.authorizationStatus
        
        if (self.manager.authorizationStatus == CLAuthorizationStatus.authorizedAlways || self.manager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse) {
            self.gpsLocation = self.manager.location?.coordinate
        }
    }
}
