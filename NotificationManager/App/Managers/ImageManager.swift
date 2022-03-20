//
//  ImageManager.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//

import Foundation
import UIKit


class ImageManager {
    static let shared = ImageManager()
    //Manager get and save Image Cache
    private var imageCache = NSCache<NSString, AnyObject>()
    
    func saveImage(_ urlStr: String?, image: UIImage? ) {
        guard let urlStr = urlStr, imageCache.object(forKey: urlStr as NSString) == nil, let image = image else {
            return
        }
        self.imageCache.setObject(image, forKey: urlStr as NSString)
    }
    
    func getImage(_ urlStr: String?) -> UIImage? {
        guard let urlStr = urlStr, let image = imageCache.object(forKey: urlStr as NSString) as? UIImage else {
            return nil
        }
        return image
    }
}
