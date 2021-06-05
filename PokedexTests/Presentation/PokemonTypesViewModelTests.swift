//
//  PokemonTypesViewModelTests.swift
//  PokedexTests
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import XCTest
@testable import Pokedex

final class PokemonTypesViewModelTests: XCTestCase {
    
    func test_pokemonTypes_whenGetPokemonTypesIsCalled_shouldNotBeEmpty() {
        let getPokemonTypesUseCaseMock = GetPokemonTypesUseCaseMock(
            result: .success([PokemonType(id: 1, name: "test")])
        )
        
        let sut = PokemonTypesViewModel(getPokemonTypesUseCase: getPokemonTypesUseCaseMock)
        
        let expectation = XCTestExpectation(description: "didGetPokemonTypes success")
        
        sut.didGetPokemonTypes = {
            XCTAssert(sut.pokemonTypes.count > 0)
            expectation.fulfill()
        }
        
        sut.getPokemonTypes()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_didGetError_whenGetPokemonTypesIsCalled_shouldBeCalled() {
        let getPokemonTypesUseCaseMock = GetPokemonTypesUseCaseMock(
            result: .failure(PokemonTypesViewModelMockError.generic)
        )
        
        let sut = PokemonTypesViewModel(getPokemonTypesUseCase: getPokemonTypesUseCaseMock)
        let expectation = XCTestExpectation(description: "getPokemonTypes failure")
        
        sut.didGetError = {
            XCTAssert(true)
            expectation.fulfill()
        }
        
        sut.getPokemonTypes()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_pokemonTypes_whenGetPokemonTypesIsCalled_shouldBeEmpty() {
        let getPokemonTypesUseCaseMock = GetPokemonTypesUseCaseMock(
            result: .success([])
        )
        
        let sut = PokemonTypesViewModel(getPokemonTypesUseCase: getPokemonTypesUseCaseMock)
        
        let expectation = XCTestExpectation(description: "didGetPokemonTypes success")
        
        sut.didGetPokemonTypes = {
            XCTAssertTrue(sut.pokemonTypes.isEmpty)
            expectation.fulfill()
        }
        
        sut.getPokemonTypes()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    enum PokemonTypesViewModelMockError: Error {
        case generic
    }
}
