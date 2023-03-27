//
//  DetailWriteFormCellViewModel.swift
//  UploadUsedGoods
//
//  Created by wons on 2023/03/27.
//

import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
    // View -> ViewModel
    let contentValue = PublishRelay<String?>()
}
