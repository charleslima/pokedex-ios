//
//  PokemonsViewModelTests.swift
//  PokedexTests
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import XCTest
@testable import Pokedex

final class PokemonsViewModelTests: XCTestCase {
    
    func test_pokemons_whenGetPokemonsByTypeIsCalled_shouldNotBeEmpty() {
        let getPokemonsUseCaseMock = GetPokemonsUseCaseMock(
            result: .success([Pokemon(name: "test")])
        )
        
        let sut = PokemonsViewModel(getPokemonsUseCase: getPokemonsUseCaseMock)
        
        let expectation = XCTestExpectation(description: "didGetPokemons success")
        
        sut.didGetPokemons = {
            XCTAssert(sut.pokemons.count > 0)
            expectation.fulfill()
        }
        
        sut.getPokemonsBy(typeID: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_didGetError_whenGetPokemonsByTypeIsCalled_shouldBeCalled() {
        let getPokemonsUseCaseMock = GetPokemonsUseCaseMock(
            result: .failure(PokemonsViewModelMockError.generic)
        )
        
        let sut = PokemonsViewModel(getPokemonsUseCase: getPokemonsUseCaseMock)
        let expectation = XCTestExpectation(description: "getPokemonsByType failure")
        
        sut.didGetError = {
            XCTAssert(true)
            expectation.fulfill()
        }
        
        sut.getPokemonsBy(typeID: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_pokemons_whenGetPokemonTypesIsCalled_shouldBeEmpty() {
        let getPokemonsUseCaseMock = GetPokemonsUseCaseMock(
            result: .success([])
        )
        
        let sut = PokemonsViewModel(getPokemonsUseCase: getPokemonsUseCaseMock)
        
        let expectation = XCTestExpectation(description: "didGetPokemons success")
        
        sut.didGetPokemons = {
            XCTAssertTrue(sut.pokemons.isEmpty)
            expectation.fulfill()
        }
        
        sut.getPokemonsBy(typeID: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    enum PokemonsViewModelMockError: Error {
        case generic
    }
}
