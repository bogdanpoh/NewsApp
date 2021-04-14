//
//  ViewModel.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 13.04.2021.
//

import RxSwift
import RxRelay

protocol ViewModelOutput: class {
    var viewState: Observable<ViewState> { get }
}

class ViewModel: ViewModelOutput {
    var disposeBag = DisposeBag()
    var viewStateSubj: BehaviorRelay<ViewState> = .init(value: .initial)
}

// MARK: -

extension ViewModel {
    
    var viewState: Observable<ViewState> {
        return viewStateSubj.asObservable()
    }
    
}

class NSObjectViewModel: NSObject {
    var disposeBag = DisposeBag()
}
