//
//  StringFormatter.swift
//  LearningAutoLayout
//
//  Created by дилара  on 07.10.2026.
//

import Foundation

class DisplayFormatter {
    private let minus = "−"
    
    // обычная запись: 1 234 567,89
    private let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 12
        formatter.minusSign = "−"
        return formatter
    }()
        
    private let scientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .scientific
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 5
        formatter.exponentSymbol = "e"
        formatter.minusSign = "−"
        return formatter
    }()
    
    func format(_ value: Double) -> String {
        let number = NSNumber(value: value)
        let magnitude = abs(value)
        
        if magnitude >= 1e12 {
            let text = scientificFormatter.string(from: number) ?? "0"
            return text.replacingOccurrences(of: "e", with: "e+")
        }
        
        if magnitude < 1e-9 && magnitude != 0 {
            return scientificFormatter.string(from: number) ?? "0"
        }
        
        return decimalFormatter.string(from: number) ?? "0"
    }
    
    func formatTyped(_ inputs: [String], isNegative: Bool ) -> String {
        let sign = isNegative ? minus : ""
        if inputs.isEmpty { return sign + "0" }
            
        
        let typed = inputs.joined()
        var integerPart = typed
        var rest = ""
        
        if let comma = typed.firstIndex(of: ",") {
            integerPart = String(typed[..<comma])
            rest = String(typed[comma...])
        }
        
        let integer = NSNumber(value: Double(integerPart) ?? 0)
        let grouped = decimalFormatter.string(from: integer) ?? integerPart
        
        return sign + grouped + rest
    }
}
