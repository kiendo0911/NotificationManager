//
//  NotificationCell.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//

import UIKit
import Kingfisher

class NotificationCell: UITableViewCell {
    @IBOutlet weak var imgAvt: UIImageView!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgAvt.layer.cornerRadius = 28
        self.imgAvt.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.clearView()
    }
}

extension NotificationCell {
    func configCell(_ cell: NotificationObj?, viewModel: NotificationsViewModel? = nil) {
        //ConfigCell
        guard let cell = cell else {
            return
        }
        lblMessage.setupNotificationMessageText(cell.message)
        self.imgAvt.loadImageWithURL(with: cell.image)
        self.imgType.loadImageWithURL(with: cell.icon)
        self.lblDate.text = cell.createdAt?.convertToStr()
        setupStatus(cell.status)
    }
    
    func setupStatus(_ status: Bool?) {
        self.contentView.backgroundColor = status == true ? .white : .notificationUnRead
    }
    
    private func clearView() {
        //Clear data
        self.imgAvt.image = nil
        self.imgType.image = nil
        self.lblDate.attributedText = nil
        self.contentView.backgroundColor = .white
    }
}
