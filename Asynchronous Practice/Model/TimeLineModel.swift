import Foundation
import RxDataSources

struct TimeLineModel {
    var items: [Item]
}

extension TimeLineModel: SectionModelType {
    typealias Item = [String]
    
    init(original: TimeLineModel, items: [Item] ) {
        self = original
        self.items = items
    }
}

