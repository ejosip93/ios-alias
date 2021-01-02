//
//  Team.swift
//  Alias
//
//  Created by Josip Peric on 18/12/2020.
//

import Foundation
import UIKit

class Team: Codable {
    let id: Int
    private var name: String?
    private var players: [Player]
    var points: Int = 0
    let color: UIColor?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, players, points
    }
    
    init(id: Int, name: String, color: UIColor?) {
        self.id = id
        self.name = name
        self.players = [Player(), Player()]
        self.color = color
    }
    
    init(id: Int) {
        self.id = id
        self.players = [Player(), Player()]
        color = UIColor.randomColor()
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getName() -> String? {
        return self.name
    }
    
    func getPlayers() -> [Player]? {
        return self.players
    }
    
    func setPlayerOneName(name: String) {
        self.players[0].name = name
    }
    
    func setPlayerTwoName(name: String) {
        self.players[1].name = name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(players, forKey: .players)
        try container.encode(points, forKey: .points)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try! container.decode(Int.self, forKey: .id)
        name = try! container.decode(String.self, forKey: .name)
        players = try! container.decode([Player].self, forKey: .players)
        points = try! container.decode(Int.self, forKey: .points)
        color = UIColor.randomColor()
    }

}
