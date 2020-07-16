//
//  Quadratic_SolverUITests.swift
//  Quadratic SolverUITests
//
//  Created by Andrew on 08/07/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import XCTest

class Quadratic_SolverUITests: XCTestCase {

    var app: XCUIApplication?
    var mainTitle: XCUIElement!
    var subtitle: XCUIElement!
    var root1: XCUIElement!
    var root2: XCUIElement!
    var a: XCUIElement!
    var b: XCUIElement!
    var c: XCUIElement!
    var submit: XCUIElement!
    var about: XCUIElement!
    
    override func setUpWithError() throws {
        //try super.setUpWithError()
        app = XCUIApplication()
        continueAfterFailure = false
        app?.launch()
        
        mainTitle = app?.staticTexts["LohsMethod"]
        subtitle = app?.staticTexts["solvesRealRootsOfABC"]
        root1 = app?.staticTexts["root1"]
        root2 = app?.staticTexts["root2"]
        a = app?/*@START_MENU_TOKEN@*/.textFields["aTextField"]/*[[".textFields[\"a\"]",".textFields[\"aTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        b = app?/*@START_MENU_TOKEN@*/.textFields["bTextField"]/*[[".textFields[\"b\"]",".textFields[\"bTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        c = app?/*@START_MENU_TOKEN@*/.textFields["cTextField"]/*[[".textFields[\"c\"]",".textFields[\"cTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        submit = app?.buttons["Submit"]
        about = app?.buttons["about"]
        
        
        //do not check for roots at the start because they are hidden
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: mainTitle, handler: nil)
        expectation(for: exists, evaluatedWith: subtitle, handler: nil)
        expectation(for: exists, evaluatedWith: a, handler: nil)
        expectation(for: exists, evaluatedWith: b, handler: nil)
        expectation(for: exists, evaluatedWith: c, handler: nil)
        expectation(for: exists, evaluatedWith: submit, handler: nil)
        expectation(for: exists, evaluatedWith: about, handler: nil)
        
        waitForExpectations(timeout: 15, handler: nil)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    //MARK: - single roots: solution represented in the form (x - P)²
    func testOneRoot1() { expectOneRoot(1, -2, 1, root_Expected: 1) }
    func testOneRoot2() { expectOneRoot(2, 12, 18, root_Expected: -3) }
    func testOneRoot3() { expectOneRoot(1, -14, 49, root_Expected: 7) }
    func testOneRoot4() { expectOneRoot(-1, 0, 0, root_Expected: 0) }
    func testOneRoot5() { expectOneRoot(0.5, -2, 2, root_Expected: 2) }
    func testOneRoot6() { expectOneRoot(2, 0, 0, root_Expected: 0) }
    func testOneRoot7() { expectOneRoot(-0.5, 0, 0, root_Expected: 0) }
    func testOneRoot8() { expectOneRoot(1, 3, 2.25, root_Expected: -1.5) }
    func testOneRoot9() { expectOneRoot(4, 16, 16, root_Expected: -2) }
    func testOneRoot10() { expectOneRoot(3.5, 98, 686, root_Expected: -14) }
    
    //MARK: - double roots: solution represented in the form x(x - P) or (x - P)(x - Q)
    func testTwoRoots1() { expectTwoRoots(1, 6, 5, root1_Expected: -1, root2_Expected: -5) }
    func testTwoRoots2() { expectTwoRoots(1, 8, 12, root1_Expected: -2, root2_Expected: -6) }
    func testTwoRoots3() { expectTwoRoots(2, 0, -50, root1_Expected: 5, root2_Expected: -5) }
    func testTwoRoots4() { expectTwoRoots(2, 7, 0, root1_Expected: 0, root2_Expected: -3.5) }
    func testTwoRoots5() { expectTwoRoots(0.75, 11.25, 42, root1_Expected: -7, root2_Expected: -8) }
    func testTwoRoots6() { expectTwoRoots(1, -2, 0, root1_Expected: 2, root2_Expected: 0) }
    func testTwoRoots7() { expectTwoRoots(4, -7, 0, root1_Expected: 1.75, root2_Expected: 0) }
    func testTwoRoots8() { expectTwoRoots(4, -7, 3, root1_Expected: 1, root2_Expected: 0.75) }
    func testTwoRoots9() { expectTwoRoots(1, 0, -441, root1_Expected: 21, root2_Expected: -21) }
    func testTwoRoots10() { expectTwoRoots(3.5, 0, -3.5, root1_Expected: 1, root2_Expected: -1)}
    
    //MARK: - P and Q are complex
    func testNoRoots1() { expectNoRoots(1, 0, 1) }
    func testNoRoots2() { expectNoRoots(-1, 2, -3) }
    func testNoRoots3() { expectNoRoots(-6, 3, -0.5) }
    func testNoRoots4() { expectNoRoots(1, -0.5, 0.5) }
    func testNoRoots5() { expectNoRoots(0.25, 1, 13) }
    func testNoRoots6() { expectNoRoots(0.1, 1, 5) }
    func testNoRoots7() { expectNoRoots(-3, 4, -15) }
    func testNoRoots8() { expectNoRoots(15, 15, 16) }
    func testNoRoots9() { expectNoRoots(Double(1/3), 1, 2) }
    func testNoRoots10() { expectNoRoots(6, -1.55, 0.15) }
    
    //MARK: - edge cases
    func testAllEmpty() { fillInFormText() }
    func testAEmpty() { fillInFormText(BText: "-2", CText: "1") }
    func testBEmpty() { fillInFormText(AText: "1", CText: "-1") }
    func testCEmpty() { fillInFormText(AText: "1", BText: "5") }
    func testAlphabet() { fillInFormText(AText: "a", BText: "b", CText: "c")}
    func testAlphanumeric() { fillInFormText(AText: "1a", BText: "2", CText: "3")}
    
    //MARK: - Lower-level functionality and data extraction
    func fillInFormText(AText: String = "", BText: String = "", CText: String = "") {
        a.tap()
        enterValue(AText)
               
        b.tap()
        enterValue(BText)
               
        c.tap()
        enterValue(CText)
               
        //find a coordinate on the screen and tap to clear keyboard
        tap(x: 50, y: 50)
        submit.tap()
    }
    
    func fillInForm(_ A: Double, _ B: Double, _ C: Double) {
        a.tap()
        enterValue("\(A)")
        
        b.tap()
        enterValue("\(B)")
        
        c.tap()
        enterValue("\(C)")
        
        //find a coordinate on the screen and tap to clear keyboard
        tap(x: 50, y: 50)
        submit.tap()
        
    }
    
    ///Types a given string into a keyboard. The field is defined above the method call
    func enterValue(_ N: String){
        let characters = Array(N)
        
        for character in characters {
            app?.keys["\(character)"].tap()
        }
    }
    
    func tap(x: Double, y: Double) {
        let normalized = app?.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized?.withOffset(CGVector(dx: x, dy: y))
        coordinate?.tap()
    }
    
    //Extracts the numerical values from the labels of each root
    func evaluateRootLabels() -> [Double] {
        
        var r1String: String
        var r2String: String
        var index: String.Index
        
        if root2.exists {
            index = root1.label.index(root1.label.startIndex, offsetBy: 4)
            r1String = String(root1.label[index...])
            r2String = String(root2.label[index...])
            return [Double(Float(r1String) ?? 0), Double(Float(r2String) ?? 0)]
        }
        else if root1.label == "No real roots" {
            return []
        }
        else {
            index = root1.label.index(root1.label.startIndex, offsetBy: 3)
            r1String = String(root1.label[index...])
            return [Double(Float(r1String) ?? 0)]
        }
    }
    
    func expectTwoRoots(_ A: Double, _ B: Double, _ C: Double, root1_Expected: Double, root2_Expected: Double) {
        fillInForm(A, B, C)
        
        XCTAssertTrue(root1.exists)
        XCTAssertTrue(root2.exists)
        
        //evaluate root
        let roots = evaluateRootLabels()
        XCTAssertEqual(roots.count, 2)
        XCTAssertEqual(roots[0], root1_Expected)
        XCTAssertEqual(roots[1], root2_Expected)
    }
    
    func expectOneRoot(_ A: Double, _ B: Double, _ C: Double, root_Expected: Double) {
        fillInForm(A, B, C)
         
         //check that a single root is shown
         XCTAssertTrue(root1.exists)
         XCTAssertFalse(root2.exists)
         
         //evaluate root
         let roots = evaluateRootLabels()
         XCTAssertEqual(roots.count, 1)
         XCTAssertEqual(roots[0], root_Expected)
    }
    
    func expectNoRoots(_ A: Double, _ B: Double, _ C: Double) {
        fillInForm(A, B, C)
        
        XCTAssertTrue(root1.exists)
        XCTAssertFalse(root2.exists)
        
        //evaluate root
        let roots = evaluateRootLabels()
        XCTAssertEqual(roots.count, 0)
        XCTAssertEqual(root1.label, "No real roots")
    }
}
