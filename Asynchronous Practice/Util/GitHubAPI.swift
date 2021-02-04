import Foundation
import Alamofire
import RxSwift
import RxCocoa
import SwiftyJSON

class GitHubAPI {
    
    static let shared = GitHubAPI()
    private init() {}
    
        func searchEvents(query: String) -> Observable<GitHubAPIModel> {
            return Observable.create { observer in
                let urlString = "https://api.github.com/search/repositories?q=\(query)"
                let request = AF.request(urlString, method: .get)
                    request.responseJSON(completionHandler:{ response in
                        switch response.result {
                        case .success(_):
                            let decoder = JSONDecoder()  //JSON をstructに変換
                            guard let data = response.data,
                                let result = try? decoder.decode(GitHubAPIModel.self, from: data) else { return }
                            observer.onNext(result)
                            print("データ: 取得数", result.items.count)
                        case .failure(let error):
                            observer.onError(error)
                        }
                    })
                return Disposables.create()
            }
        }
}
