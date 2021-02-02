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
                        // observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    })
                return Disposables.create()
            }
        }
}

 /*

    func get(query: String,success: ([]), failure: (Error)) {
            guard !query.isEmpty else {
                success([])
                     return
                 }

    
        
        let urlString = "https://api.github.com/search/repositories?q=\(query)"
        let request = AF.request(urlString, method: .get)
        request.responseJSON { (respons) in
            do {
                guard let data = respons.data else { return }
                print(JSON(data))
                let decode = JSONDecoder()
                // decode関数の引数にはJSONからマッピングさせたいクラスをと実際のデータを指定する
                let video = try decode.decode(Video.self, from: data)
//                success(video)
            } catch {
//                failure(error)
            }
            //
            //                switch respons.result {
            //                case .success(_):
            //                    guard let obj = respons.data else { return }
            //                    let json = JSON(obj)
            //                    //print(json)
            ////                    json.forEach { (_, json) in
            //////                        print(json) // jsonから"title"がキーのものを取得
            ////                    }
            //
            //                case .failure(_):
            //                    break
            //                }
        }
    }
    
    
    
    
}
*/
