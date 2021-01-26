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
    let numberArrayLimit: Int = 200
    
    var currentPage: Int = 0
    var currentOffset: Int {
        switch currentType {
        case .fibonachi:
            return currentPage * numberLimit
        default:
            return numbers.count
        }
        
    }
    var totalOnPage: Int {
        return numbers.count
    }
    
    private let service = NumberService()
    
    func setup(with type: NumberType) {
        currentPage = 0
        numbers.removeAll()
        
        currentType = type
        switch type {
        case .simple:
            self.simple(start: 0)
        case .fibonachi:
            self.fibonachi(start: 0)
        }
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
        let newSimple = service.simple(start: start, limit: numberLimit)
        numbers.append(contentsOf: newSimple)
        currentPage += 1
        self.onDataLoaded?()
    }
    
    func fibonachi(start: Int) {
        let newFibonacci = service.fibonacci(start: start, limit: numberLimit)
        numbers.append(contentsOf: newFibonacci)
        currentPage += 1
        self.onDataLoaded?()
    }
    
    func number(by indexPath: IndexPath) -> StructNumber? {
        guard numbers.indices.contains(indexPath.item) else {
            return nil
        }
        
        return numbers[indexPath.item]
    }
}
