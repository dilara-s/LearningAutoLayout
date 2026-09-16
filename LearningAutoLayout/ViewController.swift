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
    static let textSize: CGFloat = 20
    static let cornerRadius: CGFloat = 40
}

class ViewController: UIViewController {
    let titles: [[String]] = [
        ["AC", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"]
    ]

    let label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: Layout.textSize)
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
    
    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.layer.cornerRadius = Layout.cornerRadius
        button.backgroundColor = .systemBlue
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }
    
    func makeRow(titles: [String]) -> UIStackView{
        let stackView = UIStackView()
        
        for title in titles {
            stackView.addArrangedSubview(makeButton(title: title))
        }
        
        stackView.axis = .horizontal
        
        stackView.distribution = .fillEqually
        stackView.spacing = Layout.spacing
        
        return stackView
    }

    
    func setupButtonStack() {
        let verticalStackView = UIStackView()
        
        for row in titles {
            verticalStackView.addArrangedSubview(makeRow(titles: row))
        }
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.sideInset),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.sideInset),
            verticalStackView.widthAnchor.constraint(equalTo: verticalStackView.heightAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = Layout.spacing
        verticalStackView.distribution = .fillEqually
        
    }
}

