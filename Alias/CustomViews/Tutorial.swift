//
//  Tutorial.swift
//  Alias
//
//  Created by Josip Peric on 26/12/2020.
//

import Foundation
import UIKit

class Tutorial: UIView {
    
    lazy var addStackView: UIStackView = {
        let stackView = generateStackView("plus", "Press to add new team")
        return stackView
    }()
    
    lazy var removeStackView: UIStackView = {
        let stackView = generateStackView("delete", "Press to remove team")
        return stackView
    }()
    
    lazy var endStackView: UIStackView = {
        let stackView = generateStackView("end", "Press to end the game")
        return stackView
    }()
    
    lazy var backStackView: UIStackView = {
        let stackView = generateStackView("back", "Press to go back")
        return stackView
    }()
    
    lazy var forwardStackView: UIStackView = {
        let stackView = generateStackView("play", "Press to start game")
        return stackView
    }()
    
    lazy var scoreStackView: UIStackView = {
        let stackView = generateStackView("picker", "Scroll to choose the winning score", 22, 48)
        return stackView
    }()
    
    lazy var correctStackView: UIStackView = {
        let stackView = generateStackView("correct", "Set answer state to correct (+1 point)")
        return stackView
    }()
    
    lazy var questionStackView: UIStackView = {
        let stackView = generateStackView("question", "Set answer state to unknown (0 points)")
        return stackView
    }()
    
    lazy var wrongStackView: UIStackView = {
        let stackView = generateStackView("wrong", "Set answer state to wrong (-1 point)")
        return stackView
    }()
    
    lazy var playStackView: UIStackView = {
        let stackView = generateStackView("play_next", "Play next round")
        return stackView
    }()
    
    func generateStackView(_ imageName: String, _ textForLabel: String, _ heightOfImage: CGFloat = 38, _ widthOfImage: CGFloat = 38) -> UIStackView {
        let stackView = UIStackView()
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: heightOfImage).isActive = true
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.text = textForLabel
        stackView.distribution = .fillProportionally
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = 10
        stackView.backgroundColor = UIColor.clear
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        return stackView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(addStackView)
        stackView.addArrangedSubview(removeStackView)
        stackView.addArrangedSubview(forwardStackView)
        stackView.addArrangedSubview(scoreStackView)
        stackView.addArrangedSubview(backStackView)
        stackView.addArrangedSubview(endStackView)
        stackView.addArrangedSubview(correctStackView)
        stackView.addArrangedSubview(wrongStackView)
        stackView.addArrangedSubview(questionStackView)
        stackView.addArrangedSubview(playStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.contentMode = .center
        stackView.spacing = 30
        addSubview(stackView)
    }
}
