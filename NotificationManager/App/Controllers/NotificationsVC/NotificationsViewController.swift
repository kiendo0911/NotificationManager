//
//  NotificationsViewController.swift
//  NotificationManager
//
//  Created by SGD on 18/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class NotificationsViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnCloseSearchBar: UIButton!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    var viewmodel: NotificationsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
        setupViewSubcribe()
    }
    
    private func setupView() {
        //Setup search bar
        self.searchBar.searchBarStyle = .prominent
        self.searchBar.backgroundColor = .searchBarBackground
        self.searchBar.layer.masksToBounds = true
        self.searchBar.layer.cornerRadius = 16
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.searchTextField.backgroundColor = .clear
        self.searchBar.searchTextField.tintColor = .clear
        self.searchBar.setImage(UIImage(named: "ic_search_2"), for: .search, state: .normal)
        
        //Setup tableview
        let nib = UINib(nibName: "NotificationCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "NotificationCell")
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.separatorStyle = .none
    }
}

extension NotificationsViewController {
    private func setupViewModel() {
        //SetupViewModel
        self.viewmodel = NotificationsViewModel()
        self.viewmodel.handleLoadNotification()
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfNotification> { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
            
            cell.configCell(item, viewModel: self.viewmodel)
            return cell
        }
        
        self.viewmodel.notifiResponse.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        self.viewmodel.isHideIndicator.subscribe({[weak self] res in
            let value = res.element
            if value == true {
                self?.hideIndicator()
            } else {
                self?.showIndicator()
            }
        }).disposed(by: disposeBag)
        
        self.viewmodel.isHideSearchBar.subscribe({[weak self] res in
            let value = res.element
            if value == true {
                self?.hideSearchBar()
            } else {
                self?.showSearchBar()
            }
        }).disposed(by: disposeBag)
        
        self.viewmodel
            .messageError.asObserver()
            .subscribe({ [weak self] res in
            guard let err = res.element else {return}
            self?.showToast(err.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    private func setupViewSubcribe() {
        // Setup view subcribe
        self.btnSearch
            .rx.tap
            .subscribe({ [weak self] _ in
                self?.showSearchBar()
            }).disposed(by: disposeBag)
        
        self.btnCloseSearchBar
            .rx.tap
            .subscribe({ [weak self] _ in
                self?.hideSearchBar()
                self?.viewmodel.searchNotifi("")
            }).disposed(by: disposeBag)
        
        self.searchBar
            .rx.text.orEmpty
            .subscribe(onNext: {[weak self] query in
                self?.viewmodel.isHideIndicator.onNext(false)
                self?.viewmodel.searchNotifi(query)
            }).disposed(by: disposeBag)
        
        self.tableView
            .rx.itemSelected
            .subscribe ({ [weak self] indexPath in
                guard let idx = indexPath.element else {return}
                self?.viewmodel.readNotifi(with: idx)
            }).disposed(by: disposeBag)
    }
}

extension NotificationsViewController {
    //Animation
    private func showIndicator() {
        self.indicatorView.isHidden = false
        self.activityIndicatorView.startAnimating()
    }
    
    private func hideIndicator() {
        guard !self.indicatorView.isHidden else {return}
        self.activityIndicatorView.stopAnimating()
        self.indicatorView.isHidden = true
    }
    
    private func showSearchBar() {
        self.searchView.isHidden = false
        self.navigationView.isHidden = true
    }
    
    private func hideSearchBar() {
        self.searchBar.endEditing(true)
        self.searchBar.text = nil
        self.searchView.isHidden = true
        self.navigationView.isHidden = false
    }
}
