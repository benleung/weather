//
//  LocationManager.swift
//  infra
//
//  Created by Ben Leung on 2022/05/20.
//

import CoreLocation
import WidgetKit

public class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()

    // nil if not authorized for Location, or location cannot be detected
    @Published public var gpsLocation: CLLocationCoordinate2D?
    
    public static var shared = LocationManager()
    
    public override init() {
        super.init()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyKilometer
        DispatchQueue.main.async{
            self.manager.requestAlwaysAuthorization()
            self.manager.startMonitoringSignificantLocationChanges()
        }
    }
    
    public func requestAlwaysAuthorization() {
        self.manager.requestAlwaysAuthorization()
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization \(status.rawValue)")
        print("authorizedForWidgetUpdates \(manager.isAuthorizedForWidgetUpdates)")
        
        switch status {
        case .authorizedAlways:
            self.manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            self.manager.startUpdatingLocation()
            self.manager.requestAlwaysAuthorization()

        case .notDetermined, .denied, .restricted:
            self.manager.requestAlwaysAuthorization()

        @unknown default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let minDistanceToUpdateLocation: CLLocationDistance = 2500.0  // unit: in terms of meter
        print("didUpdateLocations \(locations.last)")

        fetchLatestGpsLocation()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    /// Update gpsLocation to latest
    public func fetchLatestGpsLocation() {
        self.gpsLocation = self.manager.location?.coordinate
    }
}
