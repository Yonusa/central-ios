//
//  Constants.swift
//  Central
//
//  Created by Daniel Alberto Rodriguez Cielo on 25/03/23.
//

import Foundation

struct Constansts {
    static let url = "https://central.payonusa.com"
    
    static let login = "/api/v1/login"
    static let logout = "/api/v1/cerrarSesion?idUsuario="
    static let nodes = "/api/v1/zonas/ObtenerNodos?idNet="
    static let zones = "/api/v1/zonas/ObtenerZonas?idNet="
    static let updateZone = "/api/v1/zona/ActualizarZona"
    static let usersOfZone = "/api/v1/usuario/ObtenerUsuarios?idAdministrador="
    static let addUser = "/api/v1/usuario/RegistrarUsuario"
    
    // Location urls
    static let googleMaps = ""
    static let appleMaps = "https://www.google.com/maps/dir/?api=1&travelmode=driving&layer=traffic&destination="

}
