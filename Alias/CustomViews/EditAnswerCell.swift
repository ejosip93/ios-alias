//
//  EditAnswerCell.swift
//  Alias
//
//  Created by Josip Peric on 29/12/2020.
//

import UIKit

protocol EditingAnswersProtocol {
    func answerChanged(word: Word?)
}
class EditAnswerCell: UITableViewCell {
    
    var word: Word?
    var delegate: EditingAnswersProtocol?
    
    init(word: Word) {
        super.init(style: .default, reuseIdentifier: nil)
        self.word = word
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    
    func setupCell() {
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(yesButton)
        contentView.addSubview(nobutton)
        contentView.addSubview(questionButton)
        contentView.addSubview(wordLabel)
        contentView.contentMode = .center
        setWordState()
        setupConstraints()
    }
    
    func setWordState() {
        switch word?.state {
        case .Unknown:
            setStateUnknown()
        case .Correct:
            setStateCorrect()
        case .Wrong:
            setStateWrong()
        default:
            break
        }
    }
    
    func setStateUnknown() {
        questionButton.alpha = 1
        nobutton.alpha = 0.3
        yesButton.alpha = 0.3
    }
    
    func setStateCorrect() {
        yesButton.alpha = 1
        nobutton.alpha = 0.3
        questionButton.alpha = 0.3
    }
    
    func setStateWrong() {
        nobutton.alpha = 1
        questionButton.alpha = 0.3
        yesButton.alpha = 0.3
    }
    
    lazy var questionButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "question"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(questionButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var yesButton: UIButton = {
        let yesButton = UIButton()
        yesButton.setBackgroundImage(UIImage(named: "correct"), for: .normal)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        yesButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        yesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        yesButton.addTarget(self, action: #selector(correctButtonPressed), for: .touchUpInside)
        return yesButton
    }()
    
    lazy var nobutton: UIButton = {
        let noButton = UIButton()
        noButton.setBackgroundImage(UIImage(named: "wrong"), for: .normal)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        noButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        noButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        noButton.addTarget(self, action: #selector(wrongButtonPressed), for: .touchUpInside)
        return noButton
    }()
    
    lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = word?.text
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(28)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    @objc func questionButtonPressed() {
        word?.state = .Unknown
        setStateUnknown()
        delegate?.answerChanged(word: word)
    }
    
    @objc func correctButtonPressed() {
        word?.state = .Correct
        setStateCorrect()
        delegate?.answerChanged(word: word)
    }
    
    @objc func wrongButtonPressed() {
        word?.state = .Wrong
        setStateWrong()
        delegate?.answerChanged(word: word)
    }
    
    func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        yesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        nobutton.leadingAnchor.constraint(equalTo: yesButton.trailingAnchor, constant: 10).isActive = true
        questionButton.leadingAnchor.constraint(equalTo: nobutton.trailingAnchor, constant: 10).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: questionButton.trailingAnchor, constant: 10).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        wordLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

}
