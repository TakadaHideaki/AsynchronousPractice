import Foundation
import RxSwift
import RxCocoa

struct TimeLineViewModel {
    private let disposeBag = DisposeBag()
}

extension TimeLineViewModel {
    struct Input {
    }
    
    struct Output {
        let cellObj: Observable<[TimeLineModel]>
    }
    
//    func transform(input: Input) -> Output {
    func transform() -> Output {

        
        let cellObj = BehaviorRelay<[TimeLineModel]>(
            value: [TimeLineModel(items: [["a"]])]
        )


        
        return Output(cellObj: cellObj.asObservable())
    }
}
