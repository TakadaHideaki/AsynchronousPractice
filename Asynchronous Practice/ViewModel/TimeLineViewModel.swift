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
        
        var GitHubAPIModel: [GitHubAPIModel]?
        
        let _ = input.sertchWord
            //GItHubAPIからデータを取得
            .flatMap{ return model.searchEvents(query: $0) }
            //取得したデータをRxDataSourcesで表示する為、取得データを
            //TimeLineModelにデータを適合させるために一旦 var GitHubAPIModelに格納
            .subscribe(onNext: { GitHubAPIModel = $0  })
            .disposed(by: disposeBag)
      
        //取得したデータを BehaviorRelay<[TimeLineModel]>に変換
        var cellObj: BehaviorRelay<[TimeLineModel]> {
            return
                BehaviorRelay<[TimeLineModel]>(value:
                                                [TimeLineModel(items: [GitHubAPIModel!])])
        }
        
        
        

        return Output(cellObj: cellObj.asObservable())
//  ?                   cellData: gitHubData)

