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
    
    func testOneRoot() {
        fillInForm(1, 2, 1)
        
        //check that a single root is shown
        //XCTAssertTrue(root1.exists)
        //XCTAssertFalse(root2.exists)
        
        //evaluate root
        XCTAssertEqual(root1.value as! String, "-1.0")
    }
    
    func testTwoRoots() {
        fillInForm(1, 6, 5)
    }
    
    func testNoRoots() {
        fillInForm(1, 0, 1)
        
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
}
