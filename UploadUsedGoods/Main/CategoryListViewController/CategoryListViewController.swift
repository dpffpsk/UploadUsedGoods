//
//  CategoryListViewController.swift
//  UploadUsedGoods
//
//  Created by wons on 2023/03/27.
//

import UIKit
import RxSwift
import RxCocoa

class CategoryListViewController: UIViewController {
    let disposeBag = DisposeBag()
    let tableView = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: CategoryListViewModel) {
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in
                let cell = tv.dequeueReusableCell(
                    withIdentifier: String(describing: UITableViewCell.self),
                    for: IndexPath(row: row, section: 0)
                )
                cell.textLabel?.text = data.name
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.pop
            .emit(onNext: {[weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        view.backgroundColor = .systemGroupedBackground
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.tableFooterView = UIView()
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
