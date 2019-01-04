//
//  xzTrainerTests.swift
//  xzTrainerTests
//
//  Created by Xuzhi Zhang on 5/5/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
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
        
        let cube = VoidCube()
        cube.turn(.R)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testRotateUPrime() {
        let correctEdge = [2, 3, 4, 5, 6, 7, 0, 1, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let correctCorner = [3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        
        let cube = VoidCube()
        cube.turn(.UPrime)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testSune() {
        let correctEdge = [0, 1, 4, 5, 6, 7, 2, 3, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let correctCorner = [8, 6, 7, 11, 9, 10, 0, 1, 2, 5, 3, 4, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let cube = VoidCube()
        
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
        let cube = VoidCube()
        cube.turn(.D)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testRotateFPrime() {
        let correctEdge = [17, 16, 2, 3, 4, 5, 6, 7, 19, 18, 10, 11, 12, 13, 14, 15, 9, 8, 1, 0, 20, 21, 22, 23]
        let correctCorner = [10, 11, 9, 3, 4, 5, 6, 7, 8, 23, 21, 22, 2, 0, 1, 15, 16, 17, 18, 19, 20, 13, 14, 12]
        let cube = VoidCube()
        cube.turn(.FPrime)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testRotateB() {
        let correctEdge = [0, 1, 2, 3, 23, 22, 6, 7, 8, 9, 10, 11, 21, 20, 14, 15, 16, 17, 18, 19, 5, 4, 13, 12]
        let correctCorner = [0, 1, 2, 8, 6, 7, 19, 20, 18, 9, 10, 11, 12, 13, 14, 4, 5, 3, 17, 15, 16, 21, 22, 23]
        
        let cube = VoidCube()
        cube.turn(.B)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testRotateLPrime() {
        let correctEdge = [0, 1, 18, 19, 4, 5, 6, 7, 8, 9, 20, 21, 12, 13, 14, 15, 16, 17, 10, 11, 2, 3, 22, 23]
        let correctCorner = [14, 12, 13, 1, 2, 0, 6, 7, 8, 9, 10, 11, 16, 17, 15, 5, 3, 4, 18, 19, 20, 21, 22, 23]
        
        let cube = VoidCube()
        cube.turn(.LPrime)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testTPerm() {
        let correctEdge = [0, 1, 6, 7, 4, 5, 2, 3, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let correctCorner = [0, 1, 2, 3, 4, 5, 9, 10, 11, 6, 7, 8, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let cube = VoidCube()
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
    
    func testACWUPerm() {
        let correctEdge = [2, 3, 6, 7, 4, 5, 0, 1, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let correctCorner = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let cube = VoidCube()
        
        cube.turn(.M2)
        cube.turn(.U)
        cube.turn(.M)
        cube.turn(.U2)
        cube.turn(.MPrime)
        cube.turn(.U)
        cube.turn(.M2)
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testSexy() {
        let correctEdge = [0, 1, 2, 3, 6, 7, 16, 17, 8, 9, 10, 11, 12, 13, 14, 15, 4, 5, 18, 19, 20, 21, 22, 23]
        let correctCorner = [0, 1, 2, 6, 7, 8, 4, 5, 3, 22, 23, 21, 12, 13, 14, 15, 16, 17, 18, 19, 20, 10, 11, 9]
        let cube = VoidCube()
        
        cube.scrambleCube("R U R' U'")
        
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testCWUPermRU() {
        let correctEdge = [6, 7, 0, 1, 4, 5, 2, 3, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let correctCorner = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let cube = VoidCube()
        
        cube.scrambleCube("R2 U R U R' U' R' U' R' U R'")
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testCWUPermMU() {
        let correctEdge = [6, 7, 0, 1, 4, 5, 2, 3, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let correctCorner = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        let cube = VoidCube()
        
        cube.scrambleCube("M2 U' M U2 M' U' M2")
        XCTAssertTrue(cube.assertCornerEqual(to: correctCorner))
        XCTAssertTrue(cube.assertEdgeEqual(to: correctEdge))
    }
    
    func testOppositeColors() {
        XCTAssertEqual(oppositeColor(.WHITE), CubeColor.YELLOW)
        XCTAssertEqual(oppositeColor(.BLUE), CubeColor.GREEN)
        XCTAssertEqual(oppositeColor(.ORANGE), CubeColor.RED)
    }
    
    func testAdjacentColor() {
        XCTAssertEqual(rightSideColor(top: .YELLOW, front: .RED),
                       CubeColor.GREEN)
        XCTAssertEqual(rightSideColor(top: .BLUE, front: .ORANGE),
                       CubeColor.WHITE)
        XCTAssertEqual(rightSideColor(top: .GREEN, front: .WHITE),
                       CubeColor.ORANGE)
        XCTAssertEqual(rightSideColor(top: .RED, front: .YELLOW),
                       CubeColor.BLUE)
    }
    
    func testCentreCoreEqual() {
        let core1 = CentreCore(top: .WHITE, front: .GREEN)
        let core2 = CentreCore()
        XCTAssertTrue(core1 == core2)
        XCTAssertFalse(core1 == CentreCore(top: .RED, front: .BLUE))
    }
    
    func testVoidCubeEqual() {
        let cube1 = VoidCube()
        let cube2 = VoidCube()
        
        cube1.scrambleCube("R U R' U'")
        cube2.scrambleCube("U R U' R' U R U' R' U R U' R' U R U' R' U R U' R'")
        
        XCTAssertTrue(cube1 == cube2)
    }
    
    func testRotate() {
        let cube = Cube()
        cube.rotate(top: .YELLOW, front: .RED)
        
        assert(cube.solved())
        
        cube.rotate(.z2)
        cube.rotate(.yPrime)
        
        assert(cube == Cube())
    }
    
    func testSolved() {
        let cube = Cube()
        XCTAssertTrue(cube.solved())
        
        cube.rotate(.x)
        XCTAssertTrue(cube.solved())
        
        cube.rotate(.y2)
        XCTAssertTrue(cube.solved())
        
        cube.turn(.R)
        XCTAssertFalse(cube.solved())
        
        cube.turn(.LPrime)
        cube.turn(.MPrime)
        XCTAssertTrue(cube.solved())
    }
    
    /*
    func testRandom() {
        for _ in 0 ..< 20 {
            print(randomIntInRange(start: 2, end: 3))
            print(randomIntInRange(start: 0, end: 2))
            print(randomIntInRange(start: 5, end: 7))
            print()
        }
    }
 */
    
    func testScramble() {
        print(Scrambler.getRandomScrambleWithLength(from: 20, to: 28, withOrientationMangle: false))
        print(Scrambler.getRandomScrambleWithLength(from: 10, to: 15, withOrientationMangle: false))
        print(Scrambler.getRandomScrambleWithLength(from: 30, to: 50, withOrientationMangle: false))
    }
    
    func testMemo() {
        let solver_1 = CubePermutationEncoder(forScramble: "U' L2 D F2 U' L' R F2 D' U2 B R' U' B' R F D R2 F' R'")
        XCTAssert(solver_1.edgeMemo == "YQ NT CF DG XH KP K")
        XCTAssert(solver_1.cornerMemo == "SA WC GU H")
        XCTAssert(solver_1.edgeFlips == "A ")
        XCTAssert(solver_1.cornerTwists == "J' O ")
        
        let solver_2 = CubePermutationEncoder(forScramble: "R' L' F U2 R' U2 F' B' U' F U' D L U2 L R2 U2 D2 R' L D R F2 B2 L")
        XCTAssert(solver_2.edgeMemo == "DO YN SA LA GR G")
        XCTAssert(solver_2.cornerMemo == "XN IP JS A")
        XCTAssert(solver_2.edgeFlips == "E ")
        XCTAssert(solver_2.cornerTwists == "")
    }
    
    func testInverse() {
        XCTAssert(inverse(of: Turn.R) == .RPrime)
        XCTAssert(inverse(of: Turn.LPrime) == .L)
        XCTAssert(inverse(of: Turn.B2) == .B2)
    }
    
    func testAllValues() {
        for i in 0 ..< NUM_STICKERS {
            XCTAssert(EdgeSticker.allValues[i].rawValue == i)
            XCTAssert(CornerSticker.allValues[i].rawValue == i)
        }
    }
    
    func testAreInterchangeable() {
        XCTAssert(areInerchangeable(EdgePosition.BD, EdgePosition.BL))
        XCTAssert(areInerchangeable(EdgePosition.FU, EdgePosition.BU))
        XCTAssert(areInerchangeable(CornerPosition.ULB, CornerPosition.UBR))
        XCTAssert(areInerchangeable(CornerPosition.FLU, CornerPosition.RFU))
    }
    
    func testExpandConjugate() {
        let conjStr = "Lw F' Dw2: U R U' R'"
        let conjugate = Conjugate(fromString: conjStr)!
        print(conjugate.string)
        print(conjugate.expanded.string)
    }
    
    func testExpandCommutator() {
        let commStr = "U, R"
        let commutator = Commutator(fromString: commStr)!
        print(commutator.string)
        print(commutator.expanded.string)
    }
    
    func testExpandAlg() {
        let algStr = "U R U' R' : [D, L U L' U']"
        print(expand(alg: algStr).string)
    }
}
