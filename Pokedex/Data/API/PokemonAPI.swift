//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import Moya

enum PokemonAPI {
    case getPokemonTypes
    case getPokemonsByType(id: Int)
}

extension PokemonAPI: TargetType {
    
    var baseURL: URL {
        URL(string: "https://beta.pokeapi.co")!
    }
    
    var path: String {
        return "/graphql/v1beta"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .getPokemonTypes:
            return .requestParameters(parameters: ["query": "query { types: pokemon_v2_type { id name }}"],
                                      encoding: JSONEncoding.default)
        case .getPokemonsByType(let typeID):
            let query = """
            query { pokemons: pokemon_v2_pokemon(where: { pokemon_v2_pokemontypes: { pokemon_v2_type: { id: {_eq: \(typeID)} } } }) { id name abilities: pokemon_v2_pokemonabilities { ability: pokemon_v2_ability { name }} specy: pokemon_v2_pokemonspecy { color: pokemon_v2_pokemoncolor { name } } }}
            """
            return .requestParameters(parameters: ["query": query],
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
