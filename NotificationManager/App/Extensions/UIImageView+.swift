//
//  UIImageView+.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImageWithURL(with urlStr: String?, viewModel: NotificationsViewModel? = nil) {
        // Func load image
        guard let urlStr = urlStr, let url = URL(string: urlStr) else {
            return
        }
        
        // Load image in cache
        if let image = ImageManager.shared.getImage(urlStr) {
            self.image = image
            return
        } else {
            //Dowload image and save to cache
            let processor = DownsamplingImageProcessor(size: self.bounds.size)
            let option:[KingfisherOptionsInfoItem] =  [
                .processor(processor),
                .cacheOriginalImage,
                .scaleFactor(UIScreen.main.scale),
            ]

            self.kf.setImage(with: url, options: option) { result in
                switch result {
                case .success(let value):
                    self.image = value.image
                    if !Utils.shared.test {
                        Utils.shared.test = true
                        viewModel?.messageError.onNext(AnyResponseError.noImageSaved)
                    }
                case .failure(let err):
                    viewModel?.messageError.onNext(AnyResponseError.error(err))
                }
            }
        }
    }
}
