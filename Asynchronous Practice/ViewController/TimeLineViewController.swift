import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TimeLineViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    private let viewModel = TimeLineViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<TimeLineModel> (
        configureCell: { _, tableView, indexPath, item in
            switch indexPath.section {
            case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "data", for: indexPath)
            cell.backgroundColor = .white
            item.forEach {
                cell.textLabel?.text = "ID: \($0)さんからの投稿"
                print($0)
            }
            return cell
            
            default: break
            }
            return UITableViewCell()
    })
    
    lazy var tableView = { () -> UITableView in
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .red
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "data")
        self.view.addSubview(tableView)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()

    }
    
    
    private func bind() {
   
        let output = viewModel.transform()
        
        output.cellObj
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    


}

extension TimeLineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }

    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "aa"//dataSource[section].sectionTitle
        return label
    }
}
