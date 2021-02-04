import UIKit

class CustomButton: UIButton {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("Custom", for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = .orange
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 32
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 4
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
    }
}
