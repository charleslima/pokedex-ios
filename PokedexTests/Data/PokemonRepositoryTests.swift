//
//  PokemonRepositoryTests.swift
//  PokedexTests
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import XCTest
@testable import Pokedex
    
final class PokemonRepositoryTests: XCTestCase {
    
    func test_getPokemonsByType_whenCalled_shouldReturnsPokemonList() {
        let mockJSON = "[{\"id\": 1, \"name\": \"test\", \"specy\": {\"color\":{\"name\": \"red\"}}}]"
        let mockResult = try! JSONDecoder().decode([PokemonDTO].self,
                                                   from: mockJSON.data(using: .utf8)!)
        
        let client = PokemonRemoteDataSourceMock(getPokemonsByTypeResult: .success(mockResult))
        let sut = PokemonRepositoryImpl(pokemonRemoteDataSource: client)
        let expectation = XCTestExpectation(description: "getPokemonsByType success")
        
        sut.getPokemonsBy(typeID: 1, completion: { result in
            if case .success(let pokemons) = result {
                XCTAssert(pokemons.count > 0)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonsByType_whenCalled_shouldProperlyMapToDomainObject() {
        let mockJSON = "[{\"id\": 1, \"name\": \"test\", \"specy\": {\"color\":{\"name\": \"red\"}}}]"
        let mockResult = try! JSONDecoder().decode([PokemonDTO].self,
                                                   from: mockJSON.data(using: .utf8)!)
        
        let client = PokemonRemoteDataSourceMock(getPokemonsByTypeResult: .success(mockResult))
        let sut = PokemonRepositoryImpl(pokemonRemoteDataSource: client)
        let expectation = XCTestExpectation(description: "getPokemonsByType success")
        
        sut.getPokemonsBy(typeID: 1, completion: { result in
            if case .success(let pokemons) = result {
                XCTAssertEqual(pokemons[0].name, mockResult[0].name)
                XCTAssertEqual(pokemons[0].colorName, mockResult[0].specy.color.name)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonsByType_whenCalled_shouldReturnsFailure() {
        let client = PokemonRemoteDataSourceMock(getPokemonsByTypeResult: .failure(PokemonRepositoryMockError.generic))
        let sut = PokemonRepositoryImpl(pokemonRemoteDataSource: client)
        let expectation = XCTestExpectation(description: "getPokemonsByType failure")
        
        sut.getPokemonsBy(typeID: 1, completion: { result in
            if case let (.failure(error as PokemonRepositoryMockError)) = result {
                XCTAssert(error == .generic)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonsByType_whenCalled_shouldReturnsAnEmptyPokemonList() {
        let client = PokemonRemoteDataSourceMock(getPokemonsByTypeResult: .success([]))
        let sut = PokemonRepositoryImpl(pokemonRemoteDataSource: client)
        let expectation = XCTestExpectation(description: "getPokemonsByType empty list")
        
        sut.getPokemonsBy(typeID: 1, completion: { result in
            if case .success(let pokemons) = result {
                XCTAssert(pokemons.isEmpty)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    enum PokemonRepositoryMockError: Error {
        case generic
    }
    
}
