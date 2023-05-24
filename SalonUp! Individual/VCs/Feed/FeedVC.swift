//
//  FeedVC.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 21.05.2023.
//

import SwiftUI
import MapKit
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var userLocation: CLLocation?

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async { [weak self] in
                self?.userLocation = location
            }
        }
    }
}


struct FeedVC: View {
    
    @State var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.220365, longitude: 28.907517), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    var body: some View {
        TabView {
            
            VStack {
                Text("Feed")
            }
                .tabItem {
                    Image(systemName: "scissors")
                }
                .tag(0)
            
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                .onAppear {
                    if let userLocation = locationManager.userLocation {
                        region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                    }
                }
                .tabItem {
                    Image(systemName: "map.fill")
                }
                .tag(1)
            
            Text("Messages")
                .tabItem {
                    Image(systemName: "message.fill")
                }
                .tag(2)
            
            Text("Ayarlar")
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .tag(3)
        }
        .accentColor(.black)
    }
}

struct FeedVC_Previews: PreviewProvider {
    static var previews: some View {
        FeedVC()
    }
}
