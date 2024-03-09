import XCTest
@testable import RandomPasswordGenerator

final class RandomPasswordGeneratorTests: XCTestCase {
    func testPasswordLength() {
        let generator = RandomPasswordGenerator(length: 10, characterTypes: [.digits, .uppercase, .lowercase])
        let password = try? generator.generate()
        XCTAssertEqual(password?.count, 10)
    }
    
    func testPasswordContainsRequiredCharacterTypes() {
        let generator = RandomPasswordGenerator(length: 10, characterTypes: [.digits, .uppercase, .lowercase])
        let password = try? generator.generate()
        XCTAssertTrue(password?.contains(where: { CharacterSet.decimalDigits.contains($0.unicodeScalars.first!) }) ?? false)
        XCTAssertTrue(password?.contains(where: { CharacterSet.uppercaseLetters.contains($0.unicodeScalars.first!) }) ?? false)
        XCTAssertTrue(password?.contains(where: { CharacterSet.lowercaseLetters.contains($0.unicodeScalars.first!) }) ?? false)
    }
    
    func testPasswordExcludesSpecifiedCharacters() {
        let generator = RandomPasswordGenerator(length: 10, characterTypes: [.digits, .uppercase, .lowercase], excludedCharacters: "123ABCabc")
        let password = try? generator.generate()
        XCTAssertFalse(password?.contains(where: { "123ABCabc".contains($0) }) ?? true)
    }
    
    func testInsufficientLengthError() {
        let generator = RandomPasswordGenerator(length: 1, characterTypes: [.digits, .uppercase, .lowercase])
        XCTAssertThrowsError(try generator.generate()) { error in
            XCTAssertEqual(error as? RandomPasswordGeneratorError, .insufficientLength)
        }
    }
    
    func testEmptyCharacterTypesError() {
        let generator = RandomPasswordGenerator(length: 10, characterTypes: [])
        XCTAssertThrowsError(try generator.generate()) { error in
            XCTAssertEqual(error as? RandomPasswordGeneratorError, .emptyCharacterTypes)
        }
    }
    
    func testEmptyCharacterSetError() {
        let generator = RandomPasswordGenerator(length: 10, characterTypes: [.digits, .uppercase, .lowercase], excludedCharacters: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        XCTAssertThrowsError(try generator.generate()) { error in
            XCTAssertEqual(error as? RandomPasswordGeneratorError, .emptyCharacterSet)
        }
    }
    
    func testNoAvailableCharactersForType() {
        let generator = RandomPasswordGenerator(length: 10, characterTypes: [.digits, .uppercase, .lowercase], excludedCharacters: "0123456789")
        XCTAssertThrowsError(try generator.generate()) { error in
            XCTAssertEqual(error as? RandomPasswordGeneratorError, .noAvailableCharactersForType(.digits))
        }
    }
}
