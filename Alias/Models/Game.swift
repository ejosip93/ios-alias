//
//  Game.swift
//  Alias
//
//  Created by Josip Peric on 27/12/2020.
//

import Foundation

class Game {
    
    var teams: [Team] = []
    static var shared = Game()
    var winningScore: Int = 50
    var roundCounter: Int = 0 {
        didSet {
            if roundCounter == 0 || teams.isEmpty {
                currentTeam = 0
                currentPlayer = 0
            } else {
                let modulo = roundCounter % (teams.count * 2)
                currentPlayer = modulo / teams.count
                currentTeam = modulo % teams.count
            }
            UserDefaults.standard.set(try! JSONEncoder().encode(teams), forKey: "teams")
            UserDefaults.standard.set(winningScore, forKey: "winningScore")
            UserDefaults.standard.set(roundCounter, forKey: "roundCounter")
        }
    }
    var currentTeam: Int = 0
    var currentPlayer: Int = 0
    
    private init() {}
    
    func setTeams(teams: [Team]) {
        self.teams = teams
    }
    
    func setWinningScore(score: Int) {
        self.winningScore = score
    }
    
    func checkWinner() -> Team? {
        if teams.filter({$0.points > winningScore}).count > 0 && roundCounter % teams.count == 0 {
            let bestTeams = teams.filter({$0.points == teams.max(by: {$0.points < $1.points})?.points})
            if bestTeams.count == 1 {
                return bestTeams[0]
            }
        }
        return nil
    }
}
