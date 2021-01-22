import Foundation
import RxSwift
import RxCocoa

struct InitialViewModel {
    private let disposeBag = DisposeBag()
}
extension InitialViewModel {
    struct Input {
        let serchBtnTapped: Observable<Void>
    }
    
    struct Output {
        let serchBtnTappedEvent: Observable<Void>

        
    }
    
    func transform(input: Input) -> Output {
        
        return Output (serchBtnTappedEvent: input.serchBtnTapped)
    }
}
