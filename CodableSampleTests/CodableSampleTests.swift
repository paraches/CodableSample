//
//  CodableSampleTests.swift
//  CodableSampleTests
//
//  Created by shinichi teshirogi on 2022/02/16.
//

import XCTest
@testable import CodableSample

class CodableSampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let sphere = Sphere(position: PVector(x: 0,y: 0,z: 0), radius: 2.0)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encodedSphereData = try encoder.encode(sphere)
        guard let sphereJson = String(data: encodedSphereData, encoding: .utf8) else {
            XCTAssert(true)
            return
        }
        print("encoded: \(sphereJson)")

        let decoder = JSONDecoder()
        guard let sphereData = sphereJson.data(using: .utf8) else {
            XCTAssert(true)
            return
        }
        let decodedSphere = try decoder.decode(Sphere.self, from: sphereData)
        print("decoded: \(decodedSphere)")

        let scene = Scene(position: PVector(x: 1, y: 2, z: 3), shapes: [decodedSphere, Sphere(position: PVector(x: 10, y: 20, z: 30), radius: 5)])
        let encodedSceneData = try encoder.encode(scene)
        guard let sceneJson = String(data: encodedSceneData, encoding: .utf8) else {
            XCTAssert(true)
            return
        }
        print("scene encoded: \(sceneJson)")
        
        guard let sceneData = sceneJson.data(using: .utf8) else {
            XCTAssert(true)
            return
        }
        let decodedScene = try decoder.decode(Scene.self, from: sceneData)
        print("scene decoded: \(decodedScene)")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
