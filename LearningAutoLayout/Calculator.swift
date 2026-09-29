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

final class Calculator {
    var stringResult: String?
    var doubleResult: Double?
    var inputs: [String] = []
    var calculationsList: [CalculationsListItem] = []
    
    func inputDigit(_ digit: String) {
        if inputs.isEmpty && digit == "0" { return }
        if inputs.filter({ $0 != ","}).count >= 12 { return }
        inputs.append(digit)
    }
    
    func inputComma() {
        if inputs.contains(",") { return }
        if inputs.isEmpty { inputs.append("0") }
        inputs.append(",")
    }
    
    func closeNumber() {
        let el = inputs.joined().replacingOccurrences(of: ",", with: ".")
        guard let number = Double(el) else { return }
        calculationsList.append(.number(number))
    }
    
    func inputOperation(_ operation: Operations) {
        closeNumber()
        calculationsList.append(.operation(operation))
        inputs.removeAll()
    }
    
    func calculate() {
        closeNumber()
        
        var pending: Operations?
        var result: Double?
    
        for item in calculationsList {
            switch item{
            case .number(let value):
                if let operation = pending, let current = result {
                    result = apply(operation, current, value)
                    pending = nil
                } else {
                    result = value
                }
            case .operation(let operation):
                pending = operation
            }
        }
        
        doubleResult = result
        toString(result)
        inputs.removeAll()
    }
    // по нажатию на кнопку равно у нас должна выполниться фнукция calculate() и на экран должен быть выведен резульатт то есть label.text = result. при этом из calcutions list должны удалиться все эеленты. тое сть нужно проверка: если мы прододлажем выичлсения то оставим как calculationList[0] = результат последнего вычисления, а если мы вводим новую цифру, то у нас должно все сборсить
    func toString(_ result: Double?) {
        let formatter = NumberFormatter()
        
        let numberObject = NSNumber(value: result ?? 0.0)
        if let formattedString = formatter.string(from: numberObject) {
            self.stringResult = formattedString
        }
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
        if inputs.isEmpty { return "0" }
        return inputs.joined(separator: "")
    }
    
    func showResult() -> String {
        guard let number = stringResult else { return "" }
        return number
    }
    
    func calculateButtonPressed() {
        calculate()
        if let calculationResult = doubleResult {
            calculationsList.append(.number(calculationResult))
        }
    }
    
    // вввожу первео число, операцию, второе число, равно и выводится результат. когда нажимаю следующее число, выводится второе число (то есть number2). то есть новая цифра почему-то дописывается сзади не результата а сзади числа которое number2 было

}
