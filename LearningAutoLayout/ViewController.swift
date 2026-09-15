//
//  ViewController.swift
//  LearningAutoLayout
//
//  Created by дилара  on 15.09.2026.
//

import UIKit

class ViewController: UIViewController {
    let titles: [[String]] = [
        ["AC", "±", "%", "÷"],
        ["7", "8", "9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"]
    ]

    let label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
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
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    @objc func buttonTapped() {
        print("button pressed")
    }
    
    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle("\(title)", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.layer.cornerRadius = 40
        button.backgroundColor = .systemBlue
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }
    
    func makeRow(row: [String]) -> UIStackView{
        let stackView = UIStackView()
        
        for i in row {
            stackView.addArrangedSubview(makeButton(title: i))
        }
        
        stackView.axis = .horizontal
        
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        return stackView
    }

    
    func setupButtonStack() {
        let verticalStackView = UIStackView()
        
        for i in titles {
            verticalStackView.addArrangedSubview(makeRow(row: i))
        }
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStackView.widthAnchor.constraint(equalTo: verticalStackView.heightAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 12
        verticalStackView.distribution = .fillEqually
        
    }
}

