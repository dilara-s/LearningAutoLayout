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

    func show() -> String {
        if inputs.isEmpty { return "0" }
        return inputs.joined(separator: "")
    }

}
