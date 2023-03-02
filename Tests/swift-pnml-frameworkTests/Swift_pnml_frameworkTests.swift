import XCTest
@testable import swift_pnml_framework

final class swift_pnml_frameworkTests: XCTestCase {
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct
//        // results.
//        XCTAssertEqual(swift_pnml_framework().text, "Hello, World!")
//    }
  
  func testMyTest() {
    
    let p = PnmlParser()
    
//    p.loadPN(filePath: "petrinet1.xml")
//    p.loadPN(filePath: "NQueens-PT-05.xml")
    p.loadPN(filePath: "NQueens-PT-08.pnml")
//    p.loadPN(filePath: "/Users/damienmorard/Developer/Github/swift-pnml-framework/Sources/swift-pnml-framework/Resources/NQueens-PT-05.xml")

    
//    if let url = URL(string: "https://www.pnml.org/version-2009/examples/philo.pnml") {
//      p.loadPN(url: url)
//    }
    
    
  }
}
