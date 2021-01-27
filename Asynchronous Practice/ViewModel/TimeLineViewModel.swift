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
//        var searchWordObserver: AnyObserver<String>


    }
    
    struct Output {
        let cellObj: Observable<[TimeLineModel]>
//        let cellData : Observable<[TimeLineModel]>
    }
    
    func transform(input: Input) -> Output {
        
        var aa: [GitHubAPIModel]?
        
        let gitHubData = input.sertchWord
            .flatMap{ return model.searchEvents(query: $0) }
            .subscribe(onNext: { aa = $0  })
            .disposed(by: disposeBag)
      
        
//        let cellObj = BehaviorRelay<[TimeLineModel]>(
//            value: [TimeLineModel(items: [])]
//        )
        
        
        var cellObj: BehaviorRelay<[TimeLineModel]> {
            return
                BehaviorRelay<[TimeLineModel]>(value:
                                                [TimeLineModel(items: [aa!])])
        }
        
        
        

        return Output(cellObj: cellObj.asObservable())
//                     cellData: gitHubData)
    }
}
