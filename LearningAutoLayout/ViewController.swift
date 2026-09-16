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
    static let fontSize: CGFloat = 20
    static let cornerRadius: CGFloat = 40
    static let bottomInset: CGFloat = 16
}

class ViewController: UIViewController {
    let titles: [[String]] = [
        ["AC", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"],
    ]
    
    let lastRow: [String] = [
        "0", ",", "="
    ]
    
    lazy var buttonStack: UIStackView = {
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

    let label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: Layout.fontSize)
        label.backgroundColor = .systemGray
        label.textAlignment = .right
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Экран загрузился")
        view.backgroundColor = .systemBackground
        setupLabel()
        setupButtonStack()
    }
    
    func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.sideInset),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.sideInset),
        ])
    }
    
    @objc func buttonTapped() {
        print("button pressed")
    }
    
    func makeButton(title: String, isSquare: Bool = true) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: UIControl.State.normal)
        
        button.layer.cornerRadius = Layout.cornerRadius
        button.backgroundColor = .systemBlue

        if isSquare {
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalTo: button.heightAnchor)
            ])
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }
    
    func makeRow(titles: [String]) -> UIStackView {
        let stackView = UIStackView()
        
        for title in titles {
            stackView.addArrangedSubview(makeButton(title: title))
        }
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Layout.spacing
        
        return stackView
    }
    
    func makeLastRow() -> UIStackView {
        let lastRowStackView = UIStackView()
        for title in lastRow {
            if title == "0" {
                lastRowStackView.addArrangedSubview(makeButton(title: title, isSquare: false))
            } else {
                lastRowStackView.addArrangedSubview(makeButton(title: title))
            }
        }
        
        lastRowStackView.axis = .horizontal
        lastRowStackView.spacing = Layout.spacing
        lastRowStackView.distribution = .fill
        
        return lastRowStackView
    }
    
    func setupButtonStack() {
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.sideInset),
            buttonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.sideInset),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Layout.bottomInset)
        ])
    }
}

