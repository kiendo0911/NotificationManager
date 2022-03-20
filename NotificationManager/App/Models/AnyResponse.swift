//
//  AnyResponse.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//

import Foundation

enum AnyResponseError: Error {
    case failed
    case timeOut
    case fileNotExist
    case urlError
    case unknow
    case error(Error)
    case noImageSaved
}

enum AnyResponse {
    case success
    case failed(AnyResponseError)
}
