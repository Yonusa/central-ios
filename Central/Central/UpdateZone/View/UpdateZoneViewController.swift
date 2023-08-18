//
//  UpdateZoneViewController.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 02/04/23.
//

import UIKit
import CoreLocation

class UpdateZoneViewController: UIViewController {
    
    
    // MARK: - Vars
    var idUser: Int!
    var zonaViewModel: ZonaViewModel!
    var updateZonaViewModel: UpdateZonaViewModel!
    var authStatus = CLAuthorizationStatus.notDetermined
    var locationManager: CLLocationManager!
    
    // MARK: - Outlets
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldLatitude: UITextField!
    @IBOutlet weak var textFieldLongitude: UITextField!
    @IBOutlet weak var buttonUpdateInfo: UIButton!
    @IBOutlet weak var buttonGetLocation: UIButton!
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureValues()
    }
    
    private func configureUI() {
        textFieldConfig(textFieldName, placeholder: "Nombre", keyboardType: .default)
        textFieldConfig(textFieldLatitude, placeholder: "Latitud", keyboardType: .default)
        textFieldConfig(textFieldLongitude, placeholder: "Longitud", keyboardType: .default)
        
        buttonUpdateInfo.backgroundColor = .init(named: "Primary")
        buttonUpdateInfo.layer.cornerRadius = 20.0
        buttonUpdateInfo.layer.shadowColor = UIColor.black.cgColor
        buttonUpdateInfo.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        buttonUpdateInfo.layer.shadowRadius = 8
        buttonUpdateInfo.layer.shadowOpacity = 0.5
        buttonUpdateInfo.setTitle("Actualizar información", for: .normal)
    }
    
    private func textFieldConfig(_ textField: UITextField, placeholder: String, keyboardType: UIKeyboardType) {
        textField.setRightPaddingPoints(20)
        textField.setLeftPaddingPoints(20)
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 20.0
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        textField.layer.borderWidth = 1.0
        textField.keyboardType = keyboardType
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
    }
    
    private func configureValues() {
        textFieldName.text = zonaViewModel.name
        textFieldLatitude.placeholder = zonaViewModel.coordinateX
        textFieldLongitude.placeholder = zonaViewModel.coordinateY
        textFieldLatitude.isUserInteractionEnabled = false
        textFieldLongitude.isUserInteractionEnabled = false
        configLocationManager()
    }
    
    // MARK: - Actions
    @IBAction func updateInfo(_ sender: Any) {
        guard let name = textFieldName.text, !name.isEmpty else { return }
        
        if let coordinateX = textFieldLatitude.text , !coordinateX.isEmpty,
           let coordinateY = textFieldLongitude.text, !coordinateY.isEmpty {
            updateZonaViewModel.updateZone(idUser: idUser, viewModel: zonaViewModel, coordinateX: coordinateX, coordinateY: coordinateX, nombre: name)
        } else {
            updateZonaViewModel.updateZone(idUser: idUser, viewModel: zonaViewModel, nombre: name)
        }
        
        self.dismiss(animated: true)
    }
    
    @IBAction func getLocation(_ sender: Any) {
        requestLocation()
    }
    
}

// MARK: - GetLocation
extension UpdateZoneViewController: CLLocationManagerDelegate {
    
    func configLocationManager() {
        // Create a CLLocationManager and assign a delegate
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        switch authStatus {
        case .notDetermined, .restricted, .denied:
            debugPrint("LOCATION PERMISSION REQUIRED")
        case .authorizedAlways, .authorizedWhenInUse:
            debugPrint("LOCATION GRANTED")
        @unknown default:
            break
        }
    }
    
    func requestLocation() {
        
        switch authStatus {
        case .notDetermined, .restricted, .denied:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            Alerts.settingsAlert(controller: self, title: "Atención", message: "Es necesario otorgue los permisos de ubicación")
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            textFieldLatitude.placeholder = latitude.description
            textFieldLongitude.placeholder = longitude.description
            debugPrint("Lat:\(latitude),Lon:\(longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Alerts.simpleAlert(controller: self, title: "Error", message: error.localizedDescription)
    }
}
