//
//  FileStorageTest.swift
//  infraTests
//
//  Created by Ben Leung on 2022/05/20.
//

import XCTest
import infra

class FileStorageTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        FileStorage.shared.removeFile(of: .backgroundImage)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        FileStorage.shared.removeFile(of: .backgroundImage)
    }

    func testGetSaveUIImage() throws {
        // assert
        XCTContext.runActivity(named: "Get Image before save returns nil") { _ in
            XCTAssertNil(FileStorage.shared.getUIImage(of: .backgroundImage))
        }
        
        XCTContext.runActivity(named: "Get Image after save returns no-nil") { _ in
            FileStorage.shared.saveUIImage(image: UIImage(systemName: "calendar")!, filename: .backgroundImage)
            XCTAssertNotNil(FileStorage.shared.getUIImage(of: .backgroundImage))
        }
    }

}
