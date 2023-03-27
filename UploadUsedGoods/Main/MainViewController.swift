//
//  MainViewController.swift
//  UploadUsedGoods
//
//  Created by wons on 2023/03/27.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    let submitButton = UIBarButtonItem()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MainViewModel) {
        
    }
    
    func attribute() {
        title = "중고거래 글쓰기"
        view.backgroundColor = .systemGroupedBackground
        
        submitButton.title = "제출"
        submitButton.style = .done
        
        navigationItem.setRightBarButton(submitButton, animated: true)
        
        tableView.backgroundColor = .white
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell")   // index row 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")            // index row 1
        tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: "PriceTextFieldCell")   // index row 2
        tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: "DetailWriteFormCell") // index row 3
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
    }
    
    func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

typealias Alert = (title: String, message: String?)

extension Reactive where Base: MainViewController {
    var setAlert: Binder<Alert> {
        return Binder(base) { base, data in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            let alert = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(alert)
            base.present(alertController, animated: true, completion: nil)
        }
    }
}
