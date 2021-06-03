//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import Moya

enum PokemonAPI {
    case getPokemonTypes
}

extension PokemonAPI: TargetType {
    
    var baseURL: URL {
        URL(string: "https://pokeapi.co/api/v2")!
    }
    
    var path: String {
        switch  self {
        case .getPokemonTypes:
            return "/type"
        default:
            return "/"
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
