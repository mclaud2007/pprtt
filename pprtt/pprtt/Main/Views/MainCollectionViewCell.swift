//
//  MainCollectionViewCell.swift
//  pprtt
//
//  Created by Григорий Мартюшин on 26.01.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    // MARK: - Label number
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Init
    override init(frame origin: CGRect) {
        super.init(frame: origin)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        numberLabel.text = nil
        backgroundColor = Constants.normalColor
    }
    
    func configure(with number: StructNumber, and indexPath: IndexPath) {
        let isOdd = indexPath.item % 2 == 0
        let isSectionOdd = indexPath.section % 2 == 0 ? !isOdd : isOdd
        backgroundColor = isSectionOdd ? Constants.oddColor : Constants.normalColor
        numberLabel.text = String(number.value)
    }
}

private extension MainCollectionViewCell {
    func configureView() {
        addSubview(numberLabel)
        
        NSLayoutConstraint(item: numberLabel,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: numberLabel,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerY,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
}

private extension MainCollectionViewCell {
    struct Constants {
        static let fontSize: CGFloat = 14
        static let oddColor: UIColor = .white
        static let normalColor: UIColor = .systemGray2
    }
}
