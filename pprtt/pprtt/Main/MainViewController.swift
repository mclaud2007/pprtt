//
//  ViewController.swift
//  pprtt
//
//  Created by Григорий Мартюшин on 26.01.2021.
//

import UIKit

class MainViewController: UIViewController {
    var viewModel: MainViewModelProtocol?
    private let reuseID = "collectionViewCellID"
    private var mainVeiw: MainView? {
        self.view as? MainView
    }
        
    // MARK: - Init
    init(viewModel: MainViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureVeiwModel()
    }
    
    override func loadView() {
        self.view = MainView()
    }
}

// MARK: - Configure UI
private extension MainViewController {
    func configureView() {
        mainVeiw?.collectionView.dataSource = self
        mainVeiw?.collectionView.delegate = self
        mainVeiw?.collectionView.register(MainCollectionViewCell.self,
                                          forCellWithReuseIdentifier: reuseID)
        mainVeiw?.delegate = self
    }
    
    func configureVeiwModel() {
        viewModel?.onDataLoaded = { [weak self] in
            guard let collectionView = self?.mainVeiw?.collectionView else { return }
            collectionView.reloadData()
        }
        
        viewModel?.setup(with: .simple)
    }
}

// MARK: - MainVeiwDelegate
extension MainViewController: MainVeiwDelegate {
    func didSegmentChanged(_ segment: Int) {
        if let currentNumberType = NumberType(rawValue: segment) {
            mainVeiw?.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            viewModel?.setup(with: currentNumberType)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalSpace = collectionView.bounds.width
        let size = totalSpace / 2
        
        return CGSize(width: size, height: Constants.cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = (scrollView.contentOffset.y) + (Constants.cellHeight * 3)
        let contentHeight = (scrollView.contentSize.height - scrollView.frame.height)
        
        if offsetY >= contentHeight {
            viewModel?.fetch(start: viewModel?.currentOffset ?? 0)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.totalOnPage ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as? MainCollectionViewCell ?? MainCollectionViewCell()
        
        if let element = viewModel?.number(by: indexPath) {
            cell.configure(with: element)
            
        }
        
        return cell
    }
}

// MARK: - Constants
private extension MainViewController {
    struct Constants {
        static let cellHeight: CGFloat = 80
    }
}
