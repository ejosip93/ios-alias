//
//  TeamScoreCell.swift
//  Alias
//
//  Created by Josip Peric on 27/12/2020.
//

import UIKit

class TeamScoreCell: UITableViewCell {

    var team: Team?
    
    init(team: Team) {
        super.init(style: .default, reuseIdentifier: nil)
        self.team = team
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    lazy var teamScoreView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 3
        view.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        view.layer.borderColor = team?.color!.cgColor
        view.addSubview(labelsStackView)
        view.addSubview(pointView)
        return view
    }()
    
    lazy var labelsStackView: UIStackView = {
        let nameStackView = UIStackView()
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        nameStackView.addArrangedSubview(teamNameLabel)
        let namesStackView = UIStackView()
        namesStackView.translatesAutoresizingMaskIntoConstraints = false
        namesStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        namesStackView.axis = .horizontal
        namesStackView.addArrangedSubview(playerOneLabel)
        namesStackView.addArrangedSubview(playerTwoLabel)
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(namesStackView)
        return stackView
    }()
    
    lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 250).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.textAlignment = .center
        label.textColor = team?.color
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(24)
        label.text = team?.getName()
        return label
    }()
    
    lazy var playerOneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 125).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.textColor = team?.color
        label.text = team?.getPlayers()![0].name
        return label
    }()
    
    lazy var playerTwoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 125).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.textColor = team?.color
        label.text = team?.getPlayers()![1].name
        return label
    }()
    
    lazy var pointView: UIView = {
        let pointView = UIView()
        pointView.layer.cornerRadius = 20
        pointView.layer.borderWidth = 3
        pointView.layer.borderColor = team?.color?.cgColor
        pointView.translatesAutoresizingMaskIntoConstraints = false
        pointView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        pointView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pointView.backgroundColor = team?.color?.withAlphaComponent(0.2)
        let label = UILabel()
        label.text = String(team!.points)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.widthAnchor.constraint(equalToConstant: 45).isActive = true
        label.textAlignment = .center
        pointView.addSubview(label)
        label.topAnchor.constraint(equalTo: pointView.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: pointView.leadingAnchor, constant: 7.5).isActive = true
        return pointView
    }()
    
    func setupCell() {
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = .clear
        contentView.addSubview(teamScoreView)
        selectionStyle = .none
        setupConstraints()
    }
    
    func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        teamScoreView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        teamScoreView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        teamScoreView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        teamScoreView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        labelsStackView.topAnchor.constraint(equalTo: teamScoreView.topAnchor, constant: 5).isActive = true
        labelsStackView.leadingAnchor.constraint(equalTo: teamScoreView.leadingAnchor, constant: 15).isActive = true
        pointView.leadingAnchor.constraint(equalTo: teamScoreView.trailingAnchor, constant: -80).isActive = true
        pointView.topAnchor.constraint(equalTo: teamScoreView.topAnchor, constant: 20).isActive = true
    }
}
