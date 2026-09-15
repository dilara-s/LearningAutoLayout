//
//  ViewController.swift
//  LearningAutoLayout
//
//  Created by дилара  on 15.09.2026.
//

import UIKit

class ViewController: UIViewController {
    
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let button = UIButton()
    let label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.tintColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.backgroundColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
        setupLabel()
        //view.backgroundColor = .red
        //view.addSubview(label)
        
    }
    
    func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 44),
            label.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
        
    }
    
    /*
    func setupStackView() {
        let stackView: UIStackView = {
            let stackView = UIStackView()
            for i in self.numbers {
                let button = UIButton()
                button.titleLabel?.text = "\(i)"
                button.backgroundColor = .systemBlue
                stackView.addArrangedSubview(button)
            }
            return stackView
        }()
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
        
        view.addSubview(stackView)
    }
*/

}

