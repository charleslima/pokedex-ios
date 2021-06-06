//
//  GetPokemonsUseCaseTests.swift
//  PokedexTests
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import XCTest
@testable import Pokedex
    
final class GetPokemonsUseCaseTests: XCTestCase {

    func test_getPokemonsByType_whenCalled_shouldReturnsPokemonList() {
        let client = PokemonRepositoryMock(result: .success([Pokemon(name: "test", imageURL: "teste", colorName: "red")]))
        let sut = GetPokemonsUseCaseImpl(pokemonRepository: client)
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
    
    func test_getPokemonsByType_whenCalled_shouldReturnsFailure() {
        let client = PokemonRepositoryMock(result: .failure(GetPokemonsUseCaseMockError.generic))
        let sut = GetPokemonsUseCaseImpl(pokemonRepository: client)
        let expectation = XCTestExpectation(description: "getPokemonByType failure")
        
        sut.getPokemonsBy(typeID: 1, completion: { result in
            if case let (.failure(error as GetPokemonsUseCaseMockError)) = result {
                XCTAssert(error == .generic)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonsByType_whenCalled_shouldReturnsAnEmptyPokemonList() {
        let client = PokemonRepositoryMock(result: .success([]))
        let sut = GetPokemonsUseCaseImpl(pokemonRepository: client)
        let expectation = XCTestExpectation(description: "getPokemonByType empty list")
        
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
    
    enum GetPokemonsUseCaseMockError: Error {
        case generic
    }
}
