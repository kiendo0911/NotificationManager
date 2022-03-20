//
//  NotificationsViewModel.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class NotificationsViewModel {
    var messageError = PublishSubject<AnyResponseError>()
    var notifiResponse = BehaviorSubject<[SectionOfNotification]>(value: [])
    var isHideIndicator = BehaviorSubject<Bool>(value: false)
    var isHideSearchBar = BehaviorSubject<Bool>(value: false)
    private var listNotifiBase = [NotificationObj]()
    private var listNotifiFilter = [NotificationObj]()
    private var disposeBag = DisposeBag()
     
    
    func handleLoadNotification() {
        //Action Load local Notification file first time
        self.isHideSearchBar.onNext(true)
        self.isHideIndicator.onNext(false)
        do {
            let json = try ReadFileJson.shared.fetchFileJson()
            let listNotifi = Utils.shared.convertJsonToNotifications(json)
            self.listNotifiBase = Utils.shared.sortListNotifiWithDate(listNotifi) ?? []
            self.searchNotifi(nil)
        } catch {
            self.messageError.onNext(AnyResponseError.error(error))
        }
    }
    
    func searchNotifi(_ str: String?) {
        //Action search Notificattions with String
        let handleFilter = self.filterNotifiWithStr(str)
        handleFilter.subscribe { response in
            self.isHideIndicator.onNext(true)
            switch response {
            case .success(let data):
                self.listNotifiFilter = data
                self.notifiResponse.onNext([SectionOfNotification(items: self.listNotifiFilter)])
            case .failure(let err):
                self.messageError.onNext(AnyResponseError.error(err))
            }
        }.disposed(by: disposeBag)
    }
    
    func readNotifi(with indexPath: IndexPath) {
        //Action tableview cell selected
        let row = indexPath.row
        guard row < self.listNotifiFilter.count else {return}
        self.listNotifiFilter[row].status = true
        self.notifiResponse.onNext([SectionOfNotification(items: self.listNotifiFilter)])
    }
}

extension NotificationsViewModel {
    
    private func filterNotifiWithStr(_ str: String?) -> Single<[NotificationObj]> {
        return Single.create { [weak self] single in
            if let self = self {
                single(.success(Utils.shared.filterNotificationsWithString(str, items: self.listNotifiBase) ?? []))
            } else {
                single(.failure(AnyResponseError.failed))
            }
            return Disposables.create()
        }
    }
}
