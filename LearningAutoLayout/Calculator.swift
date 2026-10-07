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
    case error
}

final class Calculator {
    private var state: State = .typing
    
    private let formatter = DisplayFormatter()
    
    private var inputs: [String] = []
    private var isNegative = false
    private(set) var calculationsList: [CalculationsListItem] = []
    
    var hasCurrentInput: Bool {
        switch state {
        case .typing:
            return !inputs.isEmpty
        case .awaitingSecondNumber, .result, .error:
            return false
        }
    }
    
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
        case .error:
            return
        }
        
        if inputs == ["0"] { inputs.removeAll() }
        
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
        case .error:
            return
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
        case .error:
            return
        }
        calculationsList.append(.operation(operation))
    }
    
    private func currentNumber() -> Double? {
        let text = inputs.joined().replacingOccurrences(of: ",", with: ".")
        return Double(text)
    }
    
    private func setCurrentNumber(_ number: Double) {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        formatter.maximumFractionDigits = 12
        let text = formatter.string(from: NSNumber(value: number)) ?? "0"
        inputs = text.map { String($0) }
    }
    
    private func closeNumber() {
        guard let number = currentNumber() else { return }
        calculationsList.append(.number(isNegative ? -number : number))
        inputs.removeAll()
        isNegative = false
    }
    
    func calculate() {
        switch state {
        case .typing: break
        case .awaitingSecondNumber, .result, .error: return
        }
        
        closeNumber()
        var pending: Operations?
        var result: Double = 0
        if calculationsList.isEmpty { return }
    
        do {
            for item in calculationsList {
                switch item{
                case .number(let value):
                    if let operation = pending {
                        result = try apply(operation, result, value)
                        pending = nil
                    } else {
                        result = value
                    }
                case .operation(let operation):
                    pending = operation
                }
            }
            
            state = .result(result)
        } catch {
            state = .error
        }
    }
    
    
    private func apply(_ operation: Operations, _ number1: Double, _ number2: Double) throws -> Double {
        switch operation {
        case .add:      return number1 + number2
        case .multiply: return number1 * number2
        case .divide:
            guard number2 != 0 else {
                throw CalculationError.dividedByZero
            }
            return number1 / number2
        case .subtract: return number1 - number2
        }
    }

    func show() -> String {
        switch state {
        case .typing, .awaitingSecondNumber:
            return formatter.formatTyped(inputs, isNegative: isNegative)
        case .result(let result):
            return formatter.format(result)
        case .error:
            return "Ошибка"
        }
    }
    
    func clear() {
        inputs.removeAll()
        isNegative = false
        calculationsList.removeAll()
        state = .typing
    }
    
    func clearCurrentInput() {
        switch state {
        case .typing:
            break
        case .awaitingSecondNumber, .result, .error:
            return
        }
        
        inputs.removeAll()
        isNegative = false
        state = calculationsList.isEmpty ? .typing : .awaitingSecondNumber
    }
    
    func changeSign() {
        switch state {
        case .typing:
            isNegative.toggle()
        case .result(let value):
            state = .result(-value)
        case .awaitingSecondNumber, .error:
            return
        }
    }
    
    func calculatePercent() {
        switch state {
        case .typing:
            guard let number = currentNumber() else { return }
            setCurrentNumber(number / 100)
        case .result(let value):
            state = .result(value / 100)
        case .awaitingSecondNumber, .error:
            return
        }
    }
}
