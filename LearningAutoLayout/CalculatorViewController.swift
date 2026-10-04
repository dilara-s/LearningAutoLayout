//
//  ViewController.swift
//  LearningAutoLayout
//
//  Created by дилара  on 15.09.2026.
//

import UIKit

private enum Layout {
    static let spacing: CGFloat = 12
    static let sideInset: CGFloat = 16
    static let displayFontSize: CGFloat = 80
    static let buttonFontSize: CGFloat = 32
    static let bottomInset: CGFloat = 16
    static let gridInset: CGFloat = 16
}

final class CalculatorViewController: UIViewController {
    
    private let calculator = Calculator()
    
    private let titles: [[String]] = [
        ["AC", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"],
    ]
    
    private let lastRow: [String] = [
        "0", ",", "="
    ]
    
    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView()
        for row in titles {
            buttonStack.addArrangedSubview(makeRow(titles: row))
        }
        buttonStack.addArrangedSubview(makeLastRow())
        buttonStack.axis = .vertical
        buttonStack.spacing = Layout.spacing
        buttonStack.distribution = .fillEqually
        
        return buttonStack
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .boldSystemFont(ofSize: Layout.displayFontSize)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Экран загрузился")
        view.backgroundColor = .systemBackground
        setupButtonStack()
        setupLabel()
    }
    
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: Layout.sideInset),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.sideInset),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.sideInset),
            label.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -Layout.gridInset)
        ])
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.currentTitle else {return}
        if buttonTitle == "," {
            calculator.inputComma()
        } else if let digit = Int(buttonTitle) {
            calculator.inputDigit(String(digit))
        } else if let operation = operation(for: buttonTitle) {
            calculator.inputOperation(operation)
        } else if buttonTitle == "=" {
            calculator.calculate()
        }
        
        label.text = calculator.show()
        print("button \(buttonTitle) pressed")
        print(calculator.calculationsList)
    }

    
    private func makeButton(title: String, isSquare: Bool = true) -> UIButton {
        let button = RoundButton()
        button.setTitle(title, for: UIControl.State.normal)
        
        button.backgroundColor = backgroundColor(for: title)
        button.titleLabel?.font = .systemFont(ofSize: Layout.buttonFontSize, weight: .bold)

        if isSquare {
            let squareConstraint = button.widthAnchor.constraint(equalTo: button.heightAnchor)
            squareConstraint.priority = UILayoutPriority(rawValue: 500.0)
            squareConstraint.isActive = true
        }
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    private func backgroundColor(for title: String) -> UIColor {
        switch title {
        case "AC", "±", "%":          return .systemGray3
        case "÷", "×", "−", "+", "=": return .systemOrange
        default:                      return .systemGray
        }
    }
    
    private func operation(for operation: String) -> Operations? {
        switch operation {
        case "+": return .add
        case "−": return .subtract
        case "÷": return .divide
        case "×": return .multiply
        default : return nil
        }
    }
    
    
    private func makeRow(titles: [String]) -> UIStackView {
        let stackView = UIStackView()
        
        for title in titles {
            stackView.addArrangedSubview(makeButton(title: title))
        }
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Layout.spacing
        
        return stackView
    }
    
    private func makeLastRow() -> UIStackView {
        let zero = makeButton(title: "0", isSquare: false)
        let comma = makeButton(title: ",")
        let equals = makeButton(title: "=")
        
        let lastRowStackView = UIStackView(arrangedSubviews: [zero, comma, equals])
        lastRowStackView.axis = .horizontal
        lastRowStackView.spacing = Layout.spacing
        lastRowStackView.distribution = .fill
        
        NSLayoutConstraint.activate([
            comma.widthAnchor.constraint(equalTo: equals.widthAnchor),
            zero.widthAnchor.constraint(equalTo: comma.widthAnchor, multiplier: 2, constant: Layout.spacing)
        ])
        
        
        return lastRowStackView
    }
    
    private func setupButtonStack() {
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.sideInset),
            buttonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.sideInset),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Layout.bottomInset)
        ])
    }
}

