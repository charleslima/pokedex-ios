//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import Moya

enum PokemonAPI {
    case getPokemonTypes
    case getType(id: Int)
}

extension PokemonAPI: TargetType {
    
    var baseURL: URL {
        URL(string: "https://pokeapi.co/api/v2")!
    }
    
    var path: String {
        switch  self {
        case .getPokemonTypes:
            return "/type"
        case .getType(let id):
            return "/type/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
