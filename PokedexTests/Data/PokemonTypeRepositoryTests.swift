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
        let mockResult = try! JSONDecoder().decode([PokemonTypeDTO].self,
                                                   from: "[{\"name\": \"test\"}]".data(using: .utf8)!)
        
        let client = PokemonRemoteDataSourceMock(result: .success(mockResult))
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
        let mockResult = try! JSONDecoder().decode([PokemonTypeDTO].self,
                                                   from: "[{\"name\": \"test\"}]".data(using: .utf8)!)
        
        let client = PokemonRemoteDataSourceMock(result: .success(mockResult))
        let sut = PokemonTypeRepositoryImpl(pokemonRemoteDataSource: client)
        let expectation = XCTestExpectation(description: "getPokemonTypes success")
        
        sut.getPokemonTypes(completion: { result in
            if case .success(let pokemonTypeList) = result {
                XCTAssertEqual(pokemonTypeList[0].name, mockResult[0].name)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonTypes_whenCalled_shouldReturnsFailure() {
        let client = PokemonRemoteDataSourceMock(result: .failure(PokemonTypeRepositoryMockError.generic))
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
        let client = PokemonRemoteDataSourceMock(result: .success([]))
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
    
    final class PokemonRemoteDataSourceMock: PokemonRemoteDataSource {
        
        let result: Result<[PokemonTypeDTO], Error>
        
        init(result: Result<[PokemonTypeDTO], Error>) {
            self.result = result
        }
        
        func getPokemonTypes(completion: @escaping (Result<[PokemonTypeDTO], Error>) -> Void) {
            completion(result)
        }
    }
    
    enum PokemonTypeRepositoryMockError: Error {
        case generic
    }
    
}
