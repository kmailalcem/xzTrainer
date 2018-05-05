//
//  xzTrainerTests.swift
//  xzTrainerTests
//
//  Created by Nelson Zhang on 5/5/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import XCTest
@testable import xzTrainer

class xzTrainerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRotateR() {
        let correctEdge = [0, 1, 2, 3, 4, 5, 16, 17, 8, 9, 10, 11, 12, 13, 22, 23, 14, 15, 18, 19, 20, 21, 6, 7]
        let correctCorner = [0, 1, 2, 3, 4, 5, 11, 9, 10, 22, 23, 21, 12, 13, 14, 15, 16, 17, 7, 8, 6, 20, 18, 19]
        
        let cube = CubePermutation()
        cube.turn(.R)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testRotateUPrime() {
        let correctEdge = [2, 3, 4, 5, 6, 7, 0, 1, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let correctCorner = [3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        
        let cube = CubePermutation()
        cube.turn(.UPrime)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testSune() {
        let correctEdge = [0, 1, 4, 5, 6, 7, 2, 3, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let correctCorner = [8, 6, 7, 11, 9, 10, 0, 1, 2, 5, 3, 4, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let cube = CubePermutation()
        
        cube.turn(.R)
        cube.turn(.U)
        cube.turn(.RPrime)
        cube.turn(.U)
        cube.turn(.R)
        cube.turn(.U2)
        cube.turn(.RPrime)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testRotateD() {
        let correctEdge = [0, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 15, 8, 9, 16, 17, 18, 19, 20, 21, 22, 23]
        let correctCorner = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 16, 17, 18, 19, 20, 21, 22, 23, 12, 13, 14]
        let cube = CubePermutation()
        cube.turn(.D)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testRotateFPrime() {
        let correctEdge = [17, 16, 2, 3, 4, 5, 6, 7, 19, 18, 10, 11, 12, 13, 14, 15, 9, 8, 1, 0, 20, 21, 22, 23]
        let correctCorner = [10, 11, 9, 3, 4, 5, 6, 7, 8, 23, 21, 22, 2, 0, 1, 15, 16, 17, 18, 19, 20, 13, 14, 12]
        let cube = CubePermutation()
        cube.turn(.FPrime)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testRotateB() {
        let correctEdge = [0, 1, 2, 3, 23, 22, 6, 7, 8, 9, 10, 11, 21, 20, 14, 15, 16, 17, 18, 19, 5, 4, 13, 12]
        let correctCorner = [0, 1, 2, 8, 6, 7, 19, 20, 18, 9, 10, 11, 12, 13, 14, 4, 5, 3, 17, 15, 16, 21, 22, 23]
        
        let cube = CubePermutation()
        cube.turn(.B)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testRotateLPrime() {
        let correctEdge = [0, 1, 18, 19, 4, 5, 6, 7, 8, 9, 20, 21, 12, 13, 14, 15, 16, 17, 10, 11, 2, 3, 22, 23]
        let correctCorner = [14, 12, 13, 1, 2, 0, 6, 7, 8, 9, 10, 11, 16, 17, 15, 5, 3, 4, 18, 19, 20, 21, 22, 23]
        
        let cube = CubePermutation()
        cube.turn(.LPrime)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testTPerm() {
        let correctEdge = [0, 1, 6, 7, 4, 5, 2, 3, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let correctCorner = [0, 1, 2, 3, 4, 5, 9, 10, 11, 6, 7, 8, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let cube = CubePermutation()
        cube.turn(.R)
        cube.turn(.U)
        cube.turn(.RPrime)
        cube.turn(.UPrime)
        cube.turn(.RPrime)
        cube.turn(.F)
        cube.turn(.R2)
        cube.turn(.UPrime)
        cube.turn(.RPrime)
        cube.turn(.UPrime)
        cube.turn(.R)
        cube.turn(.U)
        cube.turn(.RPrime)
        cube.turn(.FPrime)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
}
