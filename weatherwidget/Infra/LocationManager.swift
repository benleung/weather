//
//  LocationManager.swift
//  weather
//
//  Created by Ben Leung on 2022/05/15.
//

import CoreLocation
import WidgetKit

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()

    // nil if not authorized for Location, or location cannot be detected
    @Published var gpsLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest // kCLLocationAccuracyKilometer
        self.manager.requestAlwaysAuthorization()
        self.manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization \(status.rawValue)")
        
        switch status {
        case .authorizedAlways:
            self.manager.startUpdatingLocation()

        // TODO: should clarify with PdM on requirement in handling users who reject authorization
        // for example, displaying a view in Main App which prompts user to authorize with reasons, before the dialog pops out
        // in that case, LocationManager should hold `authStatus` attribute for deciding which view to display
        case .authorizedWhenInUse:
            self.manager.startUpdatingLocation()
            self.manager.requestAlwaysAuthorization()

        case .notDetermined, .denied, .restricted:
            self.manager.requestAlwaysAuthorization()

        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let minDistanceToUpdateLocation: CLLocationDistance = 2500.0  // unit: in terms of meter

        if let latestLocation = locations.last, let gpsLocation = gpsLocation {
            let lastLocation = CLLocation(latitude: gpsLocation.latitude, longitude: gpsLocation.longitude)
            if (latestLocation.distance(from: lastLocation) > minDistanceToUpdateLocation) {
                // if distance change > 2.5 km, significant enough to reflect the change to view
                self.gpsLocation = latestLocation.coordinate
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
    
    /// Update gpsLocation to latest
    func fetchLatestGpsLocation() {
        self.gpsLocation = self.manager.location?.coordinate
    }
}
