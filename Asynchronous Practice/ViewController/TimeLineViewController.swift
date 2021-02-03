import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TimeLineViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate {
    
    private let viewModel = TimeLineViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<TimeLineModel> (
        configureCell: { [weak self]  _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)//IndexPath(row: indexPath.row, section: 0))
            
            print("データ:", indexPath.row)
            
//            item.items.forEach {
//                cell.textLabel?.text = $0.name
//                cell.detailTextLabel?.text = $0.urlStr
//            }
//            cell.textLabel?.text = item.items[indexPath.row].name
//            cell.detailTextLabel?.text = item.items[indexPath.row].urlStr
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
        
        //tableViewLaout
//        tableView.topAnchor.constraint(equalTo: (self.serchTextField.bottomAnchor), constant: 10).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    
    private func bind() {
        
        let input = TimeLineViewModel.Input(
            sertchWord: self.serchTextField.rx.text.orEmpty
                .filter{ $0.count >= 1 }
                .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
                .asObservable()
            )
        
   
        let output = viewModel.transform(input: input)
        
        output.cellObj
//            .subscribe(onNext: {
//                $0.forEach{
//                    $0.items.forEach{
//                        $0.items.forEach{
//                            self.items.append($0.name)
//                            self.tableView.reloadData()
//                        }
//                    }
//                }
//            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = items[indexPath.row]
//         return cell
//     }
    


}
