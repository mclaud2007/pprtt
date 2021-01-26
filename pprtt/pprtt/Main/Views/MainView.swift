//
//  MainView.swift
//  pprtt
//
//  Created by Григорий Мартюшин on 26.01.2021.
//

import UIKit

protocol MainVeiwDelegate: class {
    func didSegmentChanged(_ segment: Int)
}

class MainView: UIView {
    // MARK: UI
    let titleLabel: UILabel = {
        let label = UILabel(frame: .infinite)
        label.backgroundColor = Constants.titleBackgroundColor
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = Constants.titleFontColor
        label.text = "Генератор"
        return label
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Простые числа", "Числа Фибоначи"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didSegmentChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.collectionViewBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    weak var delegate: MainVeiwDelegate?
    
    // MARK: - Init
    init() {
        super.init(frame: .infinite)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func didSegmentChanged(_ sender: UISegmentedControl) {
        delegate?.didSegmentChanged(sender.selectedSegmentIndex)
    }
}

private extension MainView {
    func configureView() {
        backgroundColor = .white
        self.addButons()
        self.addSegmentedControl()
        self.addCollectionView()
    }
    
    func addButons() {
        addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight).isActive = true
    }
    
    func addSegmentedControl() {
        addSubview(segmentedControl)
        
        segmentedControl.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func addCollectionView() {
        addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

private extension MainView {
    struct Constants {
        static let titleBackgroundColor = UIColor(red: 106/255,
                                                  green: 164/255,
                                                  blue: 205/255,
                                                  alpha: 1)
        
        static let labelWidth: CGFloat = UIScreen.main.bounds.width
        static let labelHeight: CGFloat = 44
        static let labelFontSize: CGFloat = 22
        static let collectionViewBackground: UIColor = .white
        static let titleFontColor: UIColor = .white
    }
}
