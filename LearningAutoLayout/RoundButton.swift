//
//  RoundButton.swift
//  LearningAutoLayout
//
//  Created by дилара  on 22.09.2026.
//

import Foundation
import UIKit

final class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
