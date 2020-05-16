import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(presentsWith_iOSPackage_predictiveModelTests.allTests),
    ]
}
#endif
