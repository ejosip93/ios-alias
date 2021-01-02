//
//  ViewController.swift
//  Alias
//
//  Created by Josip Peric on 15/12/2020.
//

import UIKit

class ViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, AddTeamProtocol {
    
    var teams: [Team] = Game.shared.teams
    
    let pickerData = [50, 60, 70, 80, 90, 100, 150, 200] as [Any]
    
    var tutorial: Tutorial!
    
    lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
        return backgroundImage
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setupNavigationBar()
        setAddAndRemoveTeamButton()
        setForwardButton()
        navigationItem.title = "Score"
        navigationItem.titleView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        tableView.backgroundView = backgroundImage
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tutorial = Tutorial()
    }
    
    private func setTutorialConstraints() {
        tutorial.translatesAutoresizingMaskIntoConstraints = false
        tutorial.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tutorial.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if teams.count == 0 {
            view.addSubview(tutorial)
            setTutorialConstraints()
        }
    }
    
    func setAddAndRemoveTeamButton() {
        let addTeamButton = UIButton()
        addTeamButton.setBackgroundImage(UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        addTeamButton.tintColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.9)
        addTeamButton.addTarget(self, action: #selector(addNewTeam), for: .touchUpInside)
        let removeTeamButton = UIButton()
        removeTeamButton.setBackgroundImage(UIImage(named: "delete")?.withRenderingMode(.alwaysOriginal), for: .normal)
        removeTeamButton.tintColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.9)
        removeTeamButton.addTarget(self, action: #selector(removeTeam), for: .touchUpInside)
        let barAddTeamButton = UIBarButtonItem(customView: addTeamButton)
        barAddTeamButton.customView?.widthAnchor.constraint(equalToConstant: 38).isActive = true
        barAddTeamButton.customView?.heightAnchor.constraint(equalToConstant: 38).isActive = true
        let barRemoveTeamButton = UIBarButtonItem(customView: removeTeamButton)
        barRemoveTeamButton.customView?.widthAnchor.constraint(equalToConstant: 38).isActive = true
        barRemoveTeamButton.customView?.heightAnchor.constraint(equalToConstant: 38).isActive = true
        navigationItem.leftBarButtonItems = [barAddTeamButton, barRemoveTeamButton]
    }
    
    func setForwardButton() {
        let forwardButton = UIButton()
        forwardButton.setBackgroundImage(UIImage(named: "play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        forwardButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        let barForwardButton = UIBarButtonItem(customView: forwardButton)
        barForwardButton.customView?.widthAnchor.constraint(equalToConstant: 42).isActive = true
        barForwardButton.customView?.heightAnchor.constraint(equalToConstant: 42).isActive = true
        navigationItem.rightBarButtonItem = barForwardButton
    }
    
    @objc func addNewTeam() {
        teams.append(Team(id: teams.count))
        tutorial.removeFromSuperview()
        tableView.reloadData()
    }
    
    @objc func startGame() {
        if(self.teams.count >= 2) {
            fillTeamNames()
            Game.shared.setTeams(teams: self.teams)
            Game.shared.roundCounter = 0
            navigationController?.pushViewController(GameLobbyViewController(style: .grouped), animated: true)
        } else {
            let alert = UIAlertController(title: "Missing teams", message: "Please add at least 2 teams to start the game!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func removeTeam() {
        if !teams.isEmpty {
            teams.removeLast()
            tableView.reloadData()
            if teams.isEmpty {
                view.addSubview(tutorial)
                setTutorialConstraints()
            }
        }
    }
    
    private func fillTeamNames() {
        teams.forEach {
            if($0.getName() == nil) {
                let number = $0.id + 1
                $0.setName(name: ("Team " + String(number)))
            }
            if($0.getPlayers()![0].name == "") {
                $0.getPlayers()![0].name = "Player 1"
            }
            if($0.getPlayers()![1].name == "") {
                $0.getPlayers()![1].name = "Player 2"
            }
        }
    }
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return pickerView
    }()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddTeamCell(team: teams[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Game.shared.setWinningScore(score: pickerData[row] as! Int)
    }
    
    func teamHasChanged(_ team: Team?) {
        if let team = team, let found = teams.firstIndex(where: {$0.id == team.id}) {
            teams[found] = team
        }
    }
}

