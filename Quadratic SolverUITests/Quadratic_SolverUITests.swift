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
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        app?.textFields[AccessibilityIDs.aTextField].typeText("")
        app?.textFields[AccessibilityIDs.bTextField].typeText("")
        app?.textFields[AccessibilityIDs.cTextField].typeText("")
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
        XCTAssertTrue(((app?.otherElements[AccessibilityIDs.root1Label].exists) != nil))
        XCTAssertFalse(((app?.otherElements[AccessibilityIDs.root2Label].exists) != nil))
    }
    
    func testTwoRoots() {
        fillInForm(1, 6, 5)
    }
    
    func testNoRoots() {
        fillInForm(1, 0, 1)
    }
    
    func fillInForm(_ A: Double, _ B: Double, _ C: Double) {
        app?.textFields[AccessibilityIDs.aTextField].typeText("\(A)")
        app?.textFields[AccessibilityIDs.bTextField].typeText("\(B)")
        app?.textFields[AccessibilityIDs.cTextField].typeText("\(C)")
    }
}
