//
//  GetPokemonTypesUseCaseTests.swift
//  PokedexTests
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import XCTest
@testable import Pokedex
    
final class GetPokemonTypesUseCaseTests: XCTestCase {

    func test_getPokemonTypes_whenCalled_shouldReturnsPokemonTypeList() {
        let client = PokemonTypesRepositoryMock(result: .success([PokemonType(name: "test")]))
        let sut = GetPokemonTypesUseCaseImpl(pokemonTypeRepository: client)
        let expectation = XCTestExpectation(description: "getPokemonTypes success")
        
        sut.getPokemonTypes(completion: { result in
            if case .success(let pokemonTypeList) = result {
                XCTAssert(pokemonTypeList.count > 0)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonTypes_whenCalled_shouldReturnsFailure() {
        let client = PokemonTypesRepositoryMock(result: .failure(GetPokemonTypesUseCaseMockError.generic))
        let sut = GetPokemonTypesUseCaseImpl(pokemonTypeRepository: client)
        let expectation = XCTestExpectation(description: "getPokemonTypes failure")
        
        sut.getPokemonTypes(completion: { result in
            if case let (.failure(error as GetPokemonTypesUseCaseMockError)) = result {
                XCTAssert(error == .generic)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonTypes_whenCalled_shouldReturnsAnEmptyPokemonTypesList() {
        let client = PokemonTypesRepositoryMock(result: .success([]))
        let sut = GetPokemonTypesUseCaseImpl(pokemonTypeRepository: client)
        let expectation = XCTestExpectation(description: "getPokemonTypes empty list")
        
        sut.getPokemonTypes(completion: { result in
            if case .success(let pokemonTypeList) = result {
                XCTAssert(pokemonTypeList.isEmpty)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    final class PokemonTypesRepositoryMock: PokemonTypeRepository {
        
        let result: Result<[PokemonType], Error>
        
        init(result: Result<[PokemonType], Error>) {
            self.result = result
        }
        
        func getPokemonTypes(completion: @escaping (Result<[PokemonType], Error>) -> Void) {
            completion(result)
        }
    }
    
    enum GetPokemonTypesUseCaseMockError: Error {
        case generic
    }
}
