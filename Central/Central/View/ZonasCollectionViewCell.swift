//
//  ZonasCollectionViewCell.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 29/01/23.
//

import UIKit
import CoreLocation
import MapKit

enum ZoneState: String {
    case on = "ON"
    case off = "OFF"
    case none = ""
    
}

enum ZonaImage: String {
    case on = "on"
    case off = "off"
    case none = "disable"
}

class ZonasCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var labelZona: UILabel!
    @IBOutlet weak private var imageSwitch: UIImageView!
    
    var idUser: Int!
    var zona: ZonaViewModel!
    var updateZonaViewModel: UpdateZonaViewModel!
    var controllerView: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20.0
        self.backgroundColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageSwitch.isUserInteractionEnabled = true
        imageSwitch.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureUI() {
        // Set Name of Zone
        labelZona.text = zona.name
        // Set State of Zone
        if zona.estado == ZoneState.on.rawValue {
            imageSwitch.image = UIImage(named: ZonaImage.on.rawValue)
            return
        }
        if zona.estado == ZoneState.off.rawValue {
            imageSwitch.image = UIImage(named: ZonaImage.off.rawValue)
            return
        }
        if zona.estado == ZoneState.none.rawValue {
            imageSwitch.image = UIImage(named: ZonaImage.none.rawValue)
            return
        }
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if zona.estado == ZoneState.on.rawValue {
            updateZonaViewModel.updateZone(idUser: idUser, viewModel: zona, estado: "0")
            return
        }
        if zona.estado == ZoneState.off.rawValue {
            updateZonaViewModel.updateZone(idUser: idUser, viewModel: zona, estado: "1")
            return
        }

    }

    @IBAction func configControl(_ sender: Any) {
        let updateInfoView = UpdateZoneViewController(nibName: "UpdateZoneViewController", bundle: nil)
        controllerView.navigationController?.present(updateInfoView, animated: true)
    }
    
    @IBAction func zoneLocation(_ sender: Any) {
        
        if zona.location.isEmpty {
            Alerts.simpleAlert(controller: controllerView, title: "Atención", message: "La ubicación no ha sido configurada")
            return
        }
        
        let locationArray = zona.location.components(separatedBy: ",")
        openMapsApp(latitud: locationArray[0], longitud: locationArray[1])
        
    }
    
    private func openMapsApp(latitud: String, longitud: String){
        
        guard let lati = Double(latitud),
              let long = Double(longitud) else { return }
        
        let latitude: CLLocationDegrees = lati
        let longitude: CLLocationDegrees = long
        
        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placeMark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = zona.name
        
        var mapItems: [MKMapItem] = [mapItem]
        for item in mapItems {
            if let name = item.name,
                let location = item.placemark.location {
                debugPrint("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                let place_Mark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                let map_Item = MKMapItem(placemark: place_Mark)
                map_Item.name = name
                mapItems.append(map_Item)
            }
        }
        MKMapItem.openMaps(with: mapItems, launchOptions: options)

    }
        
}
