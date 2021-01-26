//
//  MainViewModel.swift
//  pprtt
//
//  Created by Григорий Мартюшин on 26.01.2021.
//
import Foundation
import UIKit

enum NumberType: Int {
    case simple = 0
    case fibonachi = 1
}

protocol MainViewModelProtocol {
    var numbers: [StructNumber] { get }
    var onDataLoaded: (() -> Void)? { get set }
    var currentOffset: Int { get }
    var totalOnPage: Int { get }
    var currentPage: Int { get }
    func setup(with type: NumberType)
    func fetch(start: Int) 
    func simple(start: Int)
    func fibonachi(start: Int)
    func number(by indexPath: IndexPath) -> StructNumber?
}

final class MainViewModel: MainViewModelProtocol {
    var numbers: [StructNumber] = []
    var onDataLoaded: (() -> Void)?
    var currentType: NumberType = .simple
    var numberLimit: Int = 100
    
    var currentPage: Int = 0
    var currentOffset: Int {
        currentPage * numberLimit
    }
    var totalOnPage: Int {
        numbers.count / 2
    }
    
    private let service = NumberService()
    
    func setup(with type: NumberType) {
        currentPage = 0
        currentType = type
        numbers.removeAll()
        self.fetch(start: 0)
    }
    
    func fetch(start: Int) {
        switch currentType {
        case .simple:
            simple(start: start)
        default:
            fibonachi(start: start)
        }
    }
    
    func simple(start: Int) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            let newSimple = self.service.simple(start: start, limit: self.numberLimit)
            self.numbers.append(contentsOf: newSimple)
            self.currentPage += 1
            self.onDataLoaded?()
        }
    }
    
    func fibonachi(start: Int) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            let newFibonacci = self.service.fibonacci(start: start, limit: self.numberLimit)
            self.numbers.append(contentsOf: newFibonacci)
            self.currentPage += 1
            self.onDataLoaded?()
        }
    }
    
    func number(by indexPath: IndexPath) -> StructNumber? {
        let itemIndex = (indexPath.section * 2) + indexPath.item
        guard numbers.indices.contains(itemIndex) else {
            return nil
        }
        return numbers[itemIndex]
    }
}
