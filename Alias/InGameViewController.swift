//
//  InGameViewController.swift
//  Alias
//
//  Created by Josip Peric on 28/12/2020.
//

import UIKit

class InGameViewController: UIViewController {
    
    var roundSeconds = 60
    
    var usedWords: [Word] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
        return backgroundImage
    }()
    
    lazy var timerLabel: UILabel = {
        let timerLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 37.5, y: 100, width: 75, height: 75))
        timerLabel.text = String(roundSeconds)
        timerLabel.textColor = .white
        timerLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(42)
        timerLabel.backgroundColor = .clear
        timerLabel.layer.borderWidth = 3
        timerLabel.layer.cornerRadius = 10
        timerLabel.layer.borderColor = Game.shared.teams[Game.shared.currentTeam].color?.cgColor
        timerLabel.textAlignment = .center
        return timerLabel
    }()
    
    lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(42)
        return label
    }()
    
    lazy var wordView: UIView = {
        let view = UIView(frame: CGRect(x: 50, y: 200, width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height - 300))
        view.layer.borderWidth = 5
        view.layer.borderColor = Game.shared.teams[Game.shared.currentTeam].color?.cgColor
        view.layer.cornerRadius = 20
        let yesButton = UIButton()
        yesButton.setBackgroundImage(UIImage(named: "correct"), for: .normal)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        yesButton.addTarget(self, action: #selector(correctAnswerPressed), for: .touchUpInside)
        let noButton = UIButton()
        noButton.setBackgroundImage(UIImage(named: "wrong"), for: .normal)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        noButton.addTarget(self, action: #selector(wrongAnswerPressed), for: .touchUpInside)
        let readerLabel = UILabel()
        readerLabel.text = "Reading: " + Game.shared.teams[Game.shared.currentTeam].getPlayers()![Game.shared.currentPlayer].name
        readerLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        readerLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        readerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wordLabel)
        view.addSubview(yesButton)
        view.addSubview(noButton)
        view.addSubview(readerLabel)
        readerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        readerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        yesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5).isActive = true
        yesButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        yesButton.heightAnchor.constraint(equalToConstant: 130).isActive = true
        noButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        noButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        noButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        noButton.heightAnchor.constraint(equalToConstant: 130).isActive = true
        wordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        wordLabel.bottomAnchor.constraint(equalTo: yesButton.topAnchor, constant: -25).isActive = true
        wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        return view;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        view.addSubview(backgroundImage)
        view.addSubview(timerLabel)
        view.addSubview(wordView)
        setupConstraints()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.roundSeconds > 0 {
                self.roundSeconds -= 1
                self.timerLabel.text = String(self.roundSeconds)
            } else {
                Timer.invalidate()
                self.editAnswers()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNextWord()
    }
    
    func setupConstraints() {
        timerLabel.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 100).isActive = true
    }
    
    func setBackButton() {
        let backButton = UIButton()
        backButton.setBackgroundImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        let barBackButton = UIBarButtonItem(customView: backButton)
        barBackButton.customView?.widthAnchor.constraint(equalToConstant: 42).isActive = true
        barBackButton.customView?.heightAnchor.constraint(equalToConstant: 42).isActive = true
        navigationItem.leftBarButtonItem = barBackButton
    }
    
    @objc func correctAnswerPressed() {
        usedWords.append(Word(id:usedWords.count, text: wordLabel.text!, state: .Correct))
        setNextWord()
    }
    
    @objc func wrongAnswerPressed() {
        usedWords.append(Word(id:usedWords.count, text: wordLabel.text!, state: .Wrong))
        setNextWord()
    }
    
    private func setNextWord() {
        wordLabel.text = WordService.shared.getNextWord()
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func editAnswers() {
        usedWords.append(Word(id:usedWords.count, text: wordLabel.text!))
        let editViewController = EditViewController(words: usedWords)
        editViewController.modalPresentationStyle = .popover
        editViewController.onDismiss = {  [weak self] in
            self?.goBack()
        }
        self.present(editViewController, animated: true, completion: nil)
    }
}
