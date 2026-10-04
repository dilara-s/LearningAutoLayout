//
//  Calculator.swift
//  LearningAutoLayout
//
//  Created by дилара  on 26.09.2026.
//

import Foundation

enum CalculationsListItem {
    case number(Double)
    case operation(Operations)
}

enum State {
    case typing
    case awaitingSecondNumber
    case result(Double)
}

final class Calculator {
    private var state: State = .typing
    
    var inputs: [String] = []
    var calculationsList: [CalculationsListItem] = []
    
    func inputDigit(_ digit: String) {
        switch state {
        case .typing:
            break
        case .awaitingSecondNumber:
            state = .typing
        case .result:
            inputs.removeAll()
            calculationsList.removeAll()
            self.state = .typing
        }
        
        if (inputs.isEmpty && digit == "0") { return }
        if (inputs.filter( {$0 != ","} ).count >= 12) { return }
        inputs.append(digit)
    }
    
    func inputComma() {
        switch self.state {
        case .typing:
            break
        case .awaitingSecondNumber:
            state = .typing
        case .result:
            calculationsList.removeAll()
            state = .typing
        }
        if inputs.contains(",") { return }
        if inputs.isEmpty { inputs.append("0") }
        inputs.append(",")
    }
    
    func inputOperation(_ operation: Operations) {
        switch state {
        case .typing:
            if inputs.isEmpty { return }
            closeNumber()
            state = .awaitingSecondNumber
        case .awaitingSecondNumber:
            calculationsList.removeLast()
        case .result(let value):
            calculationsList.removeAll()
            calculationsList.append(.number(value))
            state = .awaitingSecondNumber
        }
        calculationsList.append(.operation(operation))
    }
    
    func closeNumber() {
        let el = inputs.joined().replacingOccurrences(of: ",", with: ".")
        guard let number = Double(el) else { return }
        calculationsList.append(.number(number))
        inputs.removeAll()
    }
    
    func calculate() {
        switch state {
        case .typing: break
        case .awaitingSecondNumber, .result: return
        }
        
        closeNumber()
        var pending: Operations?
        var result: Double = 0
        if calculationsList.isEmpty { return }
    
        for item in calculationsList {
            switch item{
            case .number(let value):
                if let operation = pending {
                    result = apply(operation, result, value)
                    pending = nil
                } else {
                    result = value
                }
            case .operation(let operation):
                pending = operation
            }
        }
        
        state = .result(result)
    }
    
    func toString(_ result: Double?) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let numberObject = NSNumber(value: result ?? 0.0)
        if let formattedString = formatter.string(from: numberObject) {
            return formattedString
        }
        return "Error"
    }
    
    func apply(_ operation: Operations, _ number1: Double, _ number2: Double) -> Double {
        switch operation {
        case .add:      return number1 + number2
        case .multiply: return number1 * number2
        case .divide:   return number1 / number2
        case .subtract: return number1 - number2
        }
    }

    func show() -> String {
        switch state {
        case .typing, .awaitingSecondNumber:
            return inputs.isEmpty ? "0" : inputs.joined()
        case .result(let result):
            return toString(result)
        }
    }
}
