//
//  SectionHeader.swift
//  Alias
//
//  Created by Josip Peric on 18/12/2020.
//

import Foundation
import UIKit

protocol AddTeamProtocol {
    func teamHasChanged(_ team: Team?)
}

class AddTeamCell: UITableViewCell, UITextFieldDelegate {
    
    var team: Team?
    var color: UIColor?
    var delegate: AddTeamProtocol?
    
    lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.layer.cornerRadius = 25
        headerView.layer.borderWidth = 3
        headerView.backgroundColor = .white
        headerView.layer.borderColor = color!.cgColor
        headerView.addSubview(headerImageView)
        headerView.addSubview(nameTextField)
        headerView.addSubview(separatorView)
        headerView.addSubview(playerOneTextField)
        headerView.addSubview(playerTwoTextField)
        return headerView
    }()
    
    lazy var headerImageView: UIImageView = {
        let image = UIImage(named: "new_team")
        let headerImageView = UIImageView(image: image)
        headerImageView.image?.withRenderingMode(.alwaysTemplate)
        headerImageView.tintColor = color?.withAlphaComponent(0.5)
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        headerImageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        headerImageView.layer.borderWidth = 3
        headerImageView.layer.borderColor = color?.cgColor
        headerImageView.layer.masksToBounds = false
        headerImageView.layer.cornerRadius = 28
        headerImageView.clipsToBounds = true
        return headerImageView
    }()
    
    lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.backgroundColor = color?.withAlphaComponent(0.5)
        return separatorView
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = setupTextField()
        textField.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        textField.placeholder = "Team name"
        textField.text = team?.getName() ?? nil
        return textField
    }()
    
    lazy var playerOneTextField: UITextField = {
        let textField = setupTextField()
        textField.placeholder = "Player 1"
        textField.text = team?.getPlayers()![0].name
        return textField
    }()
    
    lazy var playerTwoTextField: UITextField = {
        let textField = setupTextField()
        textField.placeholder = "Player 2"
        textField.text = team?.getPlayers()![1].name
        return textField
    }()
    
    init(team: Team) {
        super.init(style: .default, reuseIdentifier: nil)
        self.team = team
        self.color = team.color ?? UIColor.randomColor()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        self.backgroundColor = UIColor.clear
        contentView.addSubview(headerView)
        contentView.backgroundColor = .clear
        selectionStyle = .none
        setupConstraints()
    }
    
    private func setupConstraints() {
        headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        headerImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15).isActive = true
        separatorView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10).isActive = true
        separatorView.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: headerImageView.trailingAnchor, constant: 10).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor).isActive = true
        playerOneTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 30).isActive = true
        playerTwoTextField.topAnchor.constraint(equalTo: playerOneTextField.bottomAnchor, constant: 30).isActive = true
        playerOneTextField.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        playerTwoTextField.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        playerOneTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        playerTwoTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        headerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            if let text = nameTextField.text, text != "" {
                team?.setName(name: text)
            }
        case playerOneTextField:
            if let text = playerOneTextField.text, text != "" {
                team?.setPlayerOneName(name: text)
            }
        case playerTwoTextField:
            if let text = playerTwoTextField.text, text != "" {
                team?.setPlayerTwoName(name: text)
            }
        default:
            break
        }
        delegate?.teamHasChanged(team)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchBetweenTextFields(textField)
        return true
    }
    
    private func setupTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.tintColor = .gray
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.delegate = self
        return textField
    }
    
    private func switchBetweenTextFields(_ textField: UITextField) {
        textField.resignFirstResponder()
        switch textField {
        case nameTextField:
            playerOneTextField.becomeFirstResponder()
        case playerOneTextField:
            playerTwoTextField.becomeFirstResponder()
        default:
           break
        }
    }
}
