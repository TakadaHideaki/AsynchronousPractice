import UIKit

class CustomTextField: UITextField {
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.placeholder = "search"
        self.keyboardType = .default
        self.borderStyle = .roundedRect
        self.returnKeyType = .done
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }


}
