import UIKit
import RxSwift
import RxCocoa

class InitialViewController: UIViewController {
    
    private let viewModel = InitialViewModel()
    private let disposeBag = DisposeBag()

        
    private lazy var serchBtn: UIButton = {
        let btn = CustomButton()
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        btn.frame = CGRect(x: viewWidth * 0.3,
                           y: viewHeight * 0.4,
                           width: viewWidth * 0.4,
                           height: viewHeight * 0.2)
        self.view.addSubview(btn)
        return btn
    }()
    
  

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        self.navigationItem.title = "Top Page"
        bind()
    }
    
 
    
    func bind() {
        let input = InitialViewModel.Input(
            serchBtnTapped: serchBtn.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.serchBtnTappedEvent
            .bind(onNext: {
                let timeLineVC = TimeLineViewController()
                self.navigationController?.pushViewController(timeLineVC, animated: true)
            })
            .disposed(by: disposeBag)

            
            }
    

 
}
