//
//  MapsHandler.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 07/11/23.
//

import Foundation
import CoreLocation
import MapKit

struct MapItems {
    let latitud: String
    let longitud: String
    let zoneName: String
}

struct MapsHandler {
    
    static func openMapsApp(mapItems: [MapItems]) {
        
        var mkMapItems: [MKMapItem] = []
        var options: [String : NSValue]?
        
        for mapItem in mapItems {
            guard let lati = Double(mapItem.latitud),
                  let long = Double(mapItem.longitud) else { return }
            
            let latitude: CLLocationDegrees = lati
            let longitude: CLLocationDegrees = long
            
            let regionDistance: CLLocationDistance = 1000
            let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
            let placeMark = MKPlacemark(coordinate: coordinates)
            let mkMapItem = MKMapItem(placemark: placeMark)
            mkMapItem.name = mapItem.zoneName
            
            if let name = mkMapItem.name,
                let location = mkMapItem.placemark.location {
                debugPrint("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                let place_Mark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                let map_Item = MKMapItem(placemark: place_Mark)
                map_Item.name = name
                mkMapItems.append(map_Item)
            } else {
                mkMapItems.append(mkMapItem)
            }
            
        }
        
        MKMapItem.openMaps(with: mkMapItems, launchOptions: options)

    }
    
}
