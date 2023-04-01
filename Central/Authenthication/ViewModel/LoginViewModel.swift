//
//  LoginViewModel.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 25/03/23.
//

import Foundation

enum DefaultKeys: String {
    case email = "CREDENTIAL"
    case pass = "VERIFICATION"
    case userData = "USER_DATA"
}

// MARK: - LoginViewModelDelegate
protocol LoginViewModelDelegate {
    func loginSuccess()
    func showError(errorDescription: String)
    func removeSpinner()
}

// MARK: - LoginViewModel
class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    var delegate: LoginViewModelDelegate?
    
    func login(email: String, password: String) {
        self.email = email
        self.password = password
        
        requestLogin()
    }
    
    func autoLogin() {
        getCredentials()
        requestLogin()
    }
    
    // MARK: - Request
    
    private func requestLogin() {
        if email.isEmpty || password.isEmpty {
            self.delegate?.removeSpinner()
            return
        }
        
        guard let resource = EncodeAuthenthication.createResource(viewModel: self) else { return }
        
        Api.fetch(resource: resource) { result in
            switch result {
            case .success(let model):
                if model.code == 0 {
                    self.saveUserData(model: model)
                    self.delegate?.loginSuccess()
                } else {
                    self.delegate?.showError(errorDescription: model.message)
                }
                
            case .failure(let error):
                self.delegate?.showError(errorDescription: error.localizedDescription)
            }
        }
    }
    
    // MARK: - UserData
    
    private func saveUserData(model: Authenthication) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(model)
            
            UserDefaults.standard.set(data, forKey: DefaultKeys.userData.rawValue)
            UserDefaults.standard.set(email, forKey: DefaultKeys.email.rawValue)
            UserDefaults.standard.set(password, forKey: DefaultKeys.pass.rawValue)
        } catch {
            print("Unable to encode: \(error)")
        }
    }
    
    private func getCredentials() {
        guard let email = UserDefaults.standard.string(forKey: DefaultKeys.email.rawValue) else { return }
        guard let password = UserDefaults.standard.string(forKey: DefaultKeys.pass.rawValue) else { return }
        self.email = email
        self.password = password
    }
    
    public static func getUserData() -> Authenthication? {
        
        guard let data = UserDefaults.standard.data(forKey: DefaultKeys.userData.rawValue) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(Authenthication.self, from: data)
            return model
        } catch {
            print("Unable to decode: \(error)")
            return nil
        }
    }
    
}
