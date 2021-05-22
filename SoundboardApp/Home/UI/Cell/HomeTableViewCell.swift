//
//  ___HEADERFILE___
//

import UIKit
import SnapKit
class HomeTableViewCell: UITableViewCell {

    
    let personImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with image: UIImage) {
        personImageView.image = image
    }
}

private extension HomeTableViewCell {
    
    func setupUI() {
        contentView.addSubview(personImageView)
        setupConstraints()
        selectionStyle = .none
    }
    
    func setupConstraints() {
        personImageView.snp.makeConstraints { make in
            make.top.centerX.bottom.equalToSuperview().inset(20)
            make.width.height.equalTo(90).priority(.high)
        }
    }
}
