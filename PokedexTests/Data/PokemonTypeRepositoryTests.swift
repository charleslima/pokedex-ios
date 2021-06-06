//
//  PokemonTypeRepositoryTests.swift
//  PokedexTests
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import XCTest
@testable import Pokedex
    
final class PokemonTypeRepositoryTests: XCTestCase {
    
    func test_getPokemonTypes_whenCalled_shouldReturnsPokemonTypeList() {
        let mockJSON = "[{\"name\": \"test\", \"id\": 1}]"
        let mockResult = try! JSONDecoder().decode([PokemonTypeDTO].self,
                                                   from: mockJSON.data(using: .utf8)!)
        
        let client = PokemonRemoteDataSourceMock(getPokemonTypesResult: .success(mockResult))
        let sut = PokemonTypeRepositoryImpl(pokemonRemoteDataSource: client)
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
    
    func test_getPokemonTypes_whenCalled_shouldProperlyMapToDomainObject() {
        let mockJSON = "[{\"name\": \"test\", \"id\": 2}]"
        let mockResult = try! JSONDecoder().decode([PokemonTypeDTO].self,
                                                   from: mockJSON.data(using: .utf8)!)
        
        let client = PokemonRemoteDataSourceMock(getPokemonTypesResult: .success(mockResult))
        let sut = PokemonTypeRepositoryImpl(pokemonRemoteDataSource: client)
        let expectation = XCTestExpectation(description: "getPokemonTypes success")
        
        sut.getPokemonTypes(completion: { result in
            if case .success(let pokemonTypeList) = result {
                XCTAssertEqual(pokemonTypeList[0].id, 2)
                XCTAssertEqual(pokemonTypeList[0].name, mockResult[0].name)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonTypes_whenCalled_shouldReturnsFailure() {
        let client = PokemonRemoteDataSourceMock(getPokemonTypesResult: .failure(PokemonTypeRepositoryMockError.generic))
        let sut = PokemonTypeRepositoryImpl(pokemonRemoteDataSource: client)
        let expectation = XCTestExpectation(description: "getPokemonTypes failure")
        
        sut.getPokemonTypes(completion: { result in
            if case let (.failure(error as PokemonTypeRepositoryMockError)) = result {
                XCTAssert(error == .generic)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonTypes_whenCalled_shouldReturnsAnEmptyPokemonTypesList() {
        let client = PokemonRemoteDataSourceMock(getPokemonTypesResult: .success([]))
        let sut = PokemonTypeRepositoryImpl(pokemonRemoteDataSource: client)
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
    
    enum PokemonTypeRepositoryMockError: Error {
        case generic
    }
    
}
