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
                print("データ: 取得数", $0.items.count)
                cellObj.accept([TimeLineModel(items: $0.items )])

            })
            .disposed(by: disposeBag)
        
        return Output(cellObj: cellObj.asObservable())
    }
}

