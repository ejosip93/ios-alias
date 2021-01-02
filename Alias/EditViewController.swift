//
//  EditViewController.swift
//  Alias
//
//  Created by Josip Peric on 29/12/2020.
//

import UIKit

class EditViewController: UITableViewController, EditingAnswersProtocol {
    
    var words: [Word]?

    var onDismiss: (() -> ())?
    
    lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
        return backgroundImage
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = backgroundImage
        view.alpha = 0.98
        
        setScoreLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        changeGameValues()
        onDismiss?()
    }
    
    init(words: [Word]) {
        super.init(nibName: nil, bundle: nil)
        self.words = words
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleView: UIView = {
        let view = UIView()
        let title = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 20))
        title.text = "Team: " + Game.shared.teams[Game.shared.currentTeam].getName()!
        title.textColor = .white
        title.textAlignment = .center
        title.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        view.addSubview(title)
        view.addSubview(pointsLabel)
        return view
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 220, y: 10, width: 100, height: 40))
        label.textColor = .white
        label.layer.borderWidth = 3
        label.layer.borderColor = Game.shared.teams[Game.shared.currentTeam].color?.cgColor
        label.layer.cornerRadius = 20
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(36)
        return label
    }()
    
    private func setScoreLabel() {
        pointsLabel.text = String(calculatePoints())
    }
    
    private func calculatePoints() -> Int {
        let correctAnswers = words?.filter({$0.state == .Correct}).count
        let wrongAnswers = words?.filter({$0.state == .Wrong}).count
        return correctAnswers! - wrongAnswers!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EditAnswerCell(word: words![indexPath.row])
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return titleView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        80
    }
    
    func answerChanged(word: Word?) {
        if let changedWord = word, let wordIndex = words?.firstIndex(where: {$0.id == changedWord.id}) {
            words![wordIndex].state = changedWord.state
        }
        setScoreLabel()
    }
    
    private func changeGameValues() {
        Game.shared.teams[Game.shared.currentTeam].points += calculatePoints()
        Game.shared.roundCounter += 1
    }
}
