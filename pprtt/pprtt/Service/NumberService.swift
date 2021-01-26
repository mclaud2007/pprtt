//
//  NumberService.swift
//  pprtt
//
//  Created by Григорий Мартюшин on 26.01.2021.
//

import Foundation

final class NumberService {
    private func fibonacci(offset: Int) -> UInt {
        guard offset > 1 else {
            return UInt(offset)
        }
        
        var first: UInt = 0
        var last: UInt = 1
        var summ: UInt = 0
        var total = 2
        
        while (total < offset) {
            summ = first &+ last
            first = last
            last = summ
            total += 1
        }
        
        return summ
    }
    
    func fibonacci(start: Int, limit: Int) -> [StructNumber] {
        var first = fibonacci(offset: start)
        var second = fibonacci(offset: start + 1)
        
        var isOdd = start % 2 > 0
        var result: [StructNumber] = [StructNumber(value: first, isOdd: isOdd),
                                      StructNumber(value: second, isOdd: !isOdd)]
        
        let loopStart = result.count
        let loopEnd = (loopStart + limit) / 2
        
        for _ in loopStart..<loopEnd {
            let sum = first &+ second
            first = second
            second = sum
        
            let sum1 = first &+ second
            first = second
            second = sum1
            
            isOdd = !isOdd
            let firstNumber = StructNumber(value: sum, isOdd: isOdd)
            let secondNumber = StructNumber(value: sum1, isOdd: !isOdd)
            
            result.append(firstNumber)
            result.append(secondNumber)
        }
        
        return result
    }
    
    func simple(start: Int, limit: Int) -> [StructNumber] {
        var result: [StructNumber] = []
        var isOdd: Bool = start % 2 > 0
        var index = isOdd ? 1 : 2
        
        for number in start..<(start + limit) {
            if isPrime(number) {
                result.append(StructNumber(value: UInt(number), isOdd: isOdd))
                
                if index == 2 {
                    isOdd = !isOdd
                    index = 0
                }
                
                index += 1
            }
        }
                
        return result
    }
    
    func isPrime(_ number: Int) -> Bool {
        return number > 1 && !(2..<number).contains { number % $0 == 0 }
    }
}
