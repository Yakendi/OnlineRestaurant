//
//  NetworkEndpoints.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import Foundation

struct Endpoint {
    var path: String
}

// MARK: - Setup url
extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/v3/" + path
        return components.url
    }
}

// MARK: - Setup endpoints
extension Endpoint {
    static func categories() -> Self {
        Endpoint(path: "058729bd-1402-4578-88de-265481fd7d54")
    }
    
    static func menu() -> Self {
        Endpoint(path: "aba7ecaa-0a70-453b-b62d-0e326c859b3b")
    }
}
