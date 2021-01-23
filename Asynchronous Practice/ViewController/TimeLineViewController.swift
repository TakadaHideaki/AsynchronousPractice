import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TimeLineViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate {
    
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
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 150, width: view.bounds.width, height: view.bounds.height)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .red
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "data")
        self.view.addSubview(tableView)
        serchTextField.delegate = self
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        return tableView
    }()
    
    
    private lazy var serchTextField: UITextField = {
        let textField = CustomTextField()
        textField.backgroundColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        serchTextField.backgroundColor = .black
        bind()
        layout()

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
        tableView.topAnchor.constraint(equalTo: (self.serchTextField.bottomAnchor), constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true



        
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
