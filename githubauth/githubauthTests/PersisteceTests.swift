//
//  PersisteceTests.swift
//  githubauthTests
//
//  Created by Jonathan Freitas on 13/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import Foundation
import XCTest
@testable import githubauth

class PersistenceTests: XCTestCase {
    
    var user: User!
    
    override func setUp() {
        super.setUp()
        user = User(name: "Diogo Moreno", username: "morend", bio: "Olá", avatarUrl: "url", location: "Brasília", email: "morenodiogo@hotmail.com")
    }
    
    override func tearDown() {
        super.tearDown()
        user = nil
    }
    
    func testSaveGetUser() {
        let savedUser = LoginViewModel.saveUser(user)
        let gettedUser = LoginViewModel.getUser()
        XCTAssert(savedUser == user && gettedUser == savedUser)
    }
    
    func testDeleteGetUser() {
        _ = LoginViewModel.saveUser(user)
        let value = LoginViewModel.deleteUser()
        XCTAssert(value == false)
        
    }
    
}
