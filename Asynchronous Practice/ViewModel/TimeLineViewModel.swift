import Foundation
import RxSwift
import RxCocoa


struct TimeLineViewModel {
    let model = GitHubAPI.shared
    private let disposeBag = DisposeBag()
}

extension TimeLineViewModel {
    struct Input {
        let sertchWord: Observable<String>
    }
    
    struct Output {
        let cellObj: Observable<[TimeLineModel]>
    }
    
    func transform(input: Input) -> Output {
        
        let cellObj = BehaviorRelay<[TimeLineModel]>(value: [])
        
        input.sertchWord
            .flatMap{ return model.searchEvents(query: $0) } //GItHubAPIからデータを取得
            .subscribe(onNext: {
                cellObj.accept([TimeLineModel(items: $0 )])
            })
            .disposed(by: disposeBag)
        
        return Output(cellObj: cellObj.asObservable())
    }
}

