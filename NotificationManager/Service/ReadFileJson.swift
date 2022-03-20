//
//  ReadFileJson.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//

import Foundation
import RxSwift
import SwiftyJSON

class ReadFileJson {
    static let shared = ReadFileJson()
    private let fileName = "noti"
//    typealias response = Single<JSON>
    
    enum FILE_TYPE: String {
        case json
    }
    
    //Fetch Notification json
    func fetchFileJson(_ name: String? = nil, ofType: FILE_TYPE = .json) throws -> JSON {
        let fileName = name ?? fileName
        guard let path = Bundle.main.path(forResource: fileName, ofType: ofType.rawValue) else {
            throw AnyResponseError.fileNotExist
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let json = try JSON(data: data, options: .fragmentsAllowed)
            return json
        } catch let err {
            throw AnyResponseError.error(err)
        }
        
//        return Single.create { single in
//            if let path = Bundle.main.path(forResource: fileName, ofType: ofType.rawValue){
//                do {
//                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                    let json = try JSON(data: data, options: .fragmentsAllowed)
//                    single(.success(json))
//                } catch let err{
//                    single(.failure(AnyResponseError.error(err)))
//                }
//            } else {
//                single(.failure(AnyResponseError.fileNotExist))
//            }
//            return Disposables.create()
//        }
    }
    
}
