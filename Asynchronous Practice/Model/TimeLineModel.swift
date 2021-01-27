import Foundation
import RxDataSources

struct TimeLineModel {
    var items: [Item]
}

extension TimeLineModel: SectionModelType {
    typealias Item = [GitHubAPIModel]

    init(original: TimeLineModel, items: [Item] ) {
        self = original
        self.items = items
    }
}

//Decodable = 変換
struct GitHubAPIModel: Codable {
    var items: [Item]
}


struct Item: Codable {
    let name: String
    let fullName: String
    var urlStr: String { "https://github.com/\(fullName)" } //5.1からreturn削除

    //EncodeとDecodeでキー名が異なる時に一対一対応させる必要がある
    //フィールド名↑をcamelcaseに変換
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name" //←これを変換するための「CodingKeys」
    }
    
    /*
     全部スネーク(**_**)なら
     ViewModelを↓でOK
     let decoder = JSONDecoder()
     ↓↓↓↓↓↓↓↓↓↓を追加
      jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
     */

}
