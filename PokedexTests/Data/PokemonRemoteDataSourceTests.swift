//
//  PokemonRemoteDataSourceTests.swift
//  PokedexTests
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import XCTest
import Moya
@testable import Pokedex
    
final class PokemonRemoteDataSourceTests: XCTestCase {
    
    // MARK: - Pokemon Types
    
    func test_getPokemonTypes_whenCalled_shouldReturnsPokemonTypeList() {
        let mockJSON = "{\"results\": [{\"name\": \"test\", \"url\": \"https:/teste/1\"}]}"
        let client: MoyaProvider<PokemonAPI> = createProvider(
            with: mockJSON,
            statusCode: 200
        )
        
        let sut = PokemonRemoteDataSourceImpl(provider: client)
        
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
    
    func test_getPokemonTypes_whenCalled_shouldProperlyMapToDTOObject() {
        
        let name: String = "Test"
        let mockJSON = "{\"results\": [{\"name\": \"\(name)\", \"url\": \"https:/teste/1\"}]}"
        
        let client: MoyaProvider<PokemonAPI> = createProvider(
            with: mockJSON,
            statusCode: 200
        )
        
        let sut = PokemonRemoteDataSourceImpl(provider: client)
        let expectation = XCTestExpectation(description: "getPokemonTypes success")

        sut.getPokemonTypes(completion: { result in
            if case .success(let pokemonTypeList) = result {
                XCTAssertEqual(pokemonTypeList[0].name, name)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1.0)
    }

    func test_getPokemonTypes_whenCalled_shouldReturnsHttpError() {

        let client: MoyaProvider<PokemonAPI> = createProvider(
            with: "",
            statusCode: 404
        )
        
        let sut = PokemonRemoteDataSourceImpl(provider: client)
        let expectation = XCTestExpectation(description: "getPokemonTypes failure")

        sut.getPokemonTypes(completion: { result in
            if case let (.failure(error as PokemonRemoteDataSourceError)) = result {
                if case .http(let statusCode) = error {
                    XCTAssertEqual(statusCode, 404)
                } else {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonTypes_whenCalled_shouldReturnsMappingError() {

        let client: MoyaProvider<PokemonAPI> = createProvider(
            with: "{}",
            statusCode: 200
        )
        
        let sut = PokemonRemoteDataSourceImpl(provider: client)
        let expectation = XCTestExpectation(description: "getPokemonTypes failure")

        sut.getPokemonTypes(completion: { result in
            if case let (.failure(error as PokemonRemoteDataSourceError)) = result {
                if case .mapping = error {
                    XCTAssert(true)
                } else {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1.0)
    }

    func test_getPokemonTypes_whenCalled_shouldReturnsAnEmptyPokemonTypesList() {
        
        let client: MoyaProvider<PokemonAPI> = createProvider(
            with: "{\"results\": []}",
            statusCode: 200
        )
        
        let sut = PokemonRemoteDataSourceImpl(provider: client)
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
    
    // MARK: - Pokemons
    
    func test_getPokemonsByType_whenCalled_shouldReturnsPokemonList() {
        
        let mockJSON = "{\"pokemon\": [{\"pokemon\" :{\"name\": \"pikachu\"}}]}"
        
        let client: MoyaProvider<PokemonAPI> = createProvider(
            with: mockJSON,
            statusCode: 200
        )
        
        let sut = PokemonRemoteDataSourceImpl(provider: client)
        
        let expectation = XCTestExpectation(description: "getPokemonsByType success")
        
        sut.getPokemonsBy(typeID: 1,completion: { result in
            if case .success(let pokemons) = result {
                XCTAssert(pokemons.count > 0)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonsByType_whenCalled_shouldProperlyMapToDTOObject() {
        
        let name: String = "Pikachu"
        let mockJSON = "{\"pokemon\": [{\"pokemon\" :{\"name\": \"\(name)\"}}]}"
        
        let client: MoyaProvider<PokemonAPI> = createProvider(
            with: mockJSON,
            statusCode: 200
        )
        
        let sut = PokemonRemoteDataSourceImpl(provider: client)
        let expectation = XCTestExpectation(description: "getPokemonsByType success")

        sut.getPokemonsBy(typeID: 1, completion: { result in
            if case .success(let pokemons) = result {
                XCTAssertEqual(pokemons[0].name, name)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonsByType_whenCalled_shouldReturnsHttpError() {

        let client: MoyaProvider<PokemonAPI> = createProvider(
            with: "",
            statusCode: 404
        )
        
        let sut = PokemonRemoteDataSourceImpl(provider: client)
        let expectation = XCTestExpectation(description: "getPokemonsByType failure")

        sut.getPokemonsBy(typeID: 1, completion: { result in
            if case let (.failure(error as PokemonRemoteDataSourceError)) = result {
                if case .http(let statusCode) = error {
                    XCTAssertEqual(statusCode, 404)
                } else {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getPokemonByType_whenCalled_shouldReturnsMappingError() {

        let client: MoyaProvider<PokemonAPI> = createProvider(
            with: "{}",
            statusCode: 200
        )
        
        let sut = PokemonRemoteDataSourceImpl(provider: client)
        let expectation = XCTestExpectation(description: "getPokemonsByType failure")

        sut.getPokemonsBy(typeID: 1, completion: { result in
            if case let (.failure(error as PokemonRemoteDataSourceError)) = result {
                if case .mapping = error {
                    XCTAssert(true)
                } else {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1.0)
    }

    func test_getPokemonByType_whenCalled_shouldReturnsAnEmptyPokemonList() {
        
        let client: MoyaProvider<PokemonAPI> = createProvider(
            with: "{\"pokemon\": []}",
            statusCode: 200
        )
        
        let sut = PokemonRemoteDataSourceImpl(provider: client)
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
    
    // MARK: - Helpers
    
    private func createProvider(with JSON: String, statusCode: Int) -> MoyaProvider<PokemonAPI> {
        
        let endpointClosure = { (target: PokemonAPI) -> Endpoint in
            let url = URL(target: target).absoluteString
            return Endpoint(url: url,
                            sampleResponseClosure: {
                                .networkResponse(statusCode, JSON.data(using: .utf8)!)
                            },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        
        return MoyaProvider(endpointClosure: endpointClosure,
                            stubClosure: MoyaProvider.immediatelyStub)
    }
    
}
