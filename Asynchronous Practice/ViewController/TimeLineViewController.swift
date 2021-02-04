import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TimeLineViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate {
    
    private let viewModel = TimeLineViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<TimeLineModel> (
        configureCell: { [weak self]  _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = item.urlStr
            return cell
        })
    
    lazy var tableView = { () -> UITableView in
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 150, width: view.bounds.width, height: view.bounds.height)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .red
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        return tableView
    }()
    
    private lazy var serchTextField: UITextField = {
        let textField = CustomTextField()
        self.view.addSubview(textField)
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }
        
    func layout() {
        //textFieldLayout
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 44
        let height: CGFloat = navBarHeight + statusBarHeight!
        serchTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30.0).isActive = true
        serchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: height + 20).isActive = true
        serchTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        serchTextField.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    
    private func bind() {
        let input = TimeLineViewModel.Input(
            sertchWord: self.serchTextField.rx.text.orEmpty
                .filter{ $0.count >= 1 }
                .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)//遅延処理
                .asObservable()
            )
        
        let output = viewModel.transform(input: input)
        //APIから取得したデータRxDataSourcesに流す
        output.cellObj
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
