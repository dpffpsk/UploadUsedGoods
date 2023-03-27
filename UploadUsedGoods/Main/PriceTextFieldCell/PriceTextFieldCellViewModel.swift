//
//  PriceTextFieldCellViewModel.swift
//  UploadUsedGoods
//
//  Created by wons on 2023/03/27.
//

import RxCocoa
import RxSwift

struct PriceTextFieldCellViewModel {
    // ViewModel -> View
    let showFreeShareButton: Signal<Bool>
    let resetPrice: Signal<Void>
    
    // View -> ViewModel
    let priceValue = PublishRelay<String?>()
    let freeShareButtonTapped = PublishRelay<Void>()
    
    init() {
        self.showFreeShareButton = Observable
            .merge(
                priceValue.map { $0 ?? "" == "0" }, // 빈 값이거나, 0 일 경우
                freeShareButtonTapped.map { _ in false } // 버튼이 눌렸을 경우
            )
            .asSignal(onErrorJustReturn: false)
        
        self.resetPrice = freeShareButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }
}
