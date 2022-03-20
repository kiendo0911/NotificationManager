//
//  ToastManager.swift
//  NotificationManager
//
//  Created by SGD on 19/03/2022.
//

import Foundation
import UIKit

class ToastManager {
    static let shared = ToastManager()
    
    private var viewToast: UIView?
    private let delayTime = 1.5
    
    func showToast(_ vc: UIViewController, str: String) {
        // Custom toast
        self.hideToast()
        viewToast = UIView()
        guard let viewToast = viewToast else {
            return
        }
        
        viewToast.backgroundColor = .black.withAlphaComponent(0.5)
        viewToast.alpha = 0
        viewToast.layer.cornerRadius = 25
        viewToast.clipsToBounds = true
       
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = str
        
        viewToast.addSubview(label)
        vc.view.addSubview(viewToast)
        viewToast.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: viewToast.bottomAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: viewToast.topAnchor, constant: 15),
            label.leadingAnchor.constraint(equalTo: viewToast.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: viewToast.trailingAnchor, constant: -15),
            
            viewToast.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor, constant: -75),
            viewToast.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            viewToast.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 65),
            viewToast.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -65),
        ])
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            viewToast.alpha = 1.0
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: self.delayTime, options: .curveLinear) { [weak self] in
                self?.viewToast?.alpha = 0.0
            } completion: { [weak self] _ in
                self?.viewToast?.removeFromSuperview()
            }
            
        }
        
    }
    
    func hideToast() {
        guard viewToast != nil else {return}
        self.viewToast!.removeFromSuperview()
    }
}
