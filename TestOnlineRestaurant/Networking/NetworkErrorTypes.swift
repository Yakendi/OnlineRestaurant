//
//  NetworkErrorTypes.swift
//  TestOnlineRestaurant
//
//  Created by Аслан Микалаев on 28.06.2023.
//

import Foundation

enum NetworkErrorTypes: Error {
    case invalidURL
    case emptyData
    case nonHTTPResponse
    case error(error: Error)
}

extension NetworkErrorTypes: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Невалидный url адрес", comment: "Network error")
        case .emptyData:
            return NSLocalizedString("Данные не были получены", comment: "Decode error")
        case .nonHTTPResponse:
            return NSLocalizedString("Ошибка сервера", comment: "HTTP Response error")
        case .error(let error):
            return NSLocalizedString("\(error.localizedDescription)", comment: "Error")
        }
    }
}
