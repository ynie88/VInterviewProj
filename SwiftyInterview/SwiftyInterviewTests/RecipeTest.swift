//
//  RecipeTest.swift
//  SwiftyInterview
//
//  Created by Yuchen Nie on 9/8/16.
//  Copyright © 2016 Yuchen Nie. All rights reserved.
//

import XCTest
@testable import SwiftyInterview
import Quick
import Nimble

class RecipeTest:QuickSpec {
    override func spec() {
        describe("A Presenter/Interacter test") { 
            beforeEach{
                
            }
            
            context("This describes a situation in a interacter/presenter", { 
                it("It should load view data", closure: { 
                    expect(1==1).to(beTrue())
                })
                
            })
        }
    }
}

