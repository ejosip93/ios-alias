//
//  GameLobbyViewController.swift
//  Alias
//
//  Created by Josip Peric on 27/12/2020.
//

import UIKit

class GameLobbyViewController: UITableViewController {

    lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
        return backgroundImage
    }()
    
    lazy var playNextButton: UIButton = {
        let playButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 125, y: 75, width: 50, height: 50))
        playButton.setBackgroundImage(UIImage(named: "play_next")?.withRenderingMode(.alwaysOriginal), for: .normal)
        playButton.addTarget(self, action: #selector(playNextRound), for: .touchUpInside)
        playButton.isUserInteractionEnabled = true
        return playButton
    }()
    
    func setNextRoundView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        view.backgroundColor = .clear
        let headLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 20, width: 200, height: 20))
        headLabel.text = "Go to next round:"
        headLabel.textAlignment = .center
        headLabel.textColor = UIColor.white.withAlphaComponent(0.95)
        headLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(22)
        let teamLabel = UILabel(frame: CGRect(x: 75, y: 70, width: 200, height: 20))
        teamLabel.text = "Team: " + Game.shared.teams[Game.shared.currentTeam].getName()!
        teamLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        teamLabel.textColor = .white
        let playerLabel = UILabel(frame: CGRect(x: 75, y: 110, width: 200, height: 20))
        playerLabel.text = "Player: " + Game.shared.teams[Game.shared.currentTeam].getPlayers()![Game.shared.currentPlayer].name
        playerLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        playerLabel.textColor = .white

        view.addSubview(headLabel)
        view.addSubview(teamLabel)
        view.addSubview(playerLabel)
        view.addSubview(playNextButton)
        return view;
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEndGameBarButton()
        tableView.backgroundView = backgroundImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        if let winner = Game.shared.checkWinner() {
            playNextButton.isEnabled = false
            let alertController = UIAlertController(title: "The winner is: " + winner.getName()!, message: "End this game to start another!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func setEndGameBarButton() {
        let endButton = UIButton()
        endButton.translatesAutoresizingMaskIntoConstraints = false
        endButton.setBackgroundImage(UIImage(named: "end")?.withRenderingMode(.alwaysOriginal), for: .normal)
        endButton.tintColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.9)
        endButton.addTarget(self, action: #selector(endGame), for: .touchUpInside)
        let barEndButton = UIBarButtonItem(customView: endButton)
        barEndButton.customView?.widthAnchor.constraint(equalToConstant: 38).isActive = true
        barEndButton.customView?.heightAnchor.constraint(equalToConstant: 38).isActive = true
        navigationItem.leftBarButtonItem = barEndButton
    }
    
    @objc func endGame() {
        let alert = UIAlertController(title: "Are you sure?", message: "Press yes to end the game or no to cancel!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "YES", style: .default) { [weak self] _ in
            Game.shared.teams = []
            Game.shared.roundCounter = 0
            Game.shared.winningScore = 50
            let navigationController = self?.navigationController
            var controllerStack = self?.navigationController?.viewControllers
            if controllerStack?.first is GameLobbyViewController {
                controllerStack?.removeFirst()
                navigationController!.setViewControllers(controllerStack!, animated: false)
                navigationController!.pushViewController(ViewController(), animated: false)
            } else if controllerStack?.first is ViewController {
                controllerStack?.removeAll()
                navigationController!.setViewControllers(controllerStack!, animated: false)
                navigationController!.pushViewController(ViewController(), animated: false)
            }
        }
        let cancelButton = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func playNextRound() {
        navigationController?.pushViewController(InGameViewController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Game.shared.teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TeamScoreCell(team: Game.shared.teams[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setNextRoundView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
}
