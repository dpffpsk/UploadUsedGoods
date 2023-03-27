//
//  TitleTextFieldCell.swift
//  UploadUsedGoods
//
//  Created by wons on 2023/03/27.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class TitleTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    let titleInputField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TitleTextFieldViewModel) {
        titleInputField.rx.text
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
    }
    
    func attribute( ) {
        titleInputField.font = .systemFont(ofSize: 17)
    }
    
    func layout() {
        contentView.addSubview(titleInputField)
        
        titleInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
}
