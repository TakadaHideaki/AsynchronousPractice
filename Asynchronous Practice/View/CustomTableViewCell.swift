import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let nameLabelFrame = CGRect(x: 10, y: 10, width: 300, height: 0)
    let nameLabel = UILabel(frame: nameLabelFrame)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(nameLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
