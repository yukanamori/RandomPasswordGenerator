import Foundation

/// Represents the type of characters to be used in the password.
public enum CharacterType {
    case digits, uppercase, lowercase
    /// Includes all ASCII symbols except for space.
    case specialCharacters

    /// Returns a string of characters corresponding to the character type.
    public var characters: String {
        switch self {
        case .digits:
            return (48...57).map { String(UnicodeScalar($0)) }.joined()
        case .uppercase:
            return (65...90).map { String(UnicodeScalar($0)) }.joined()
        case .lowercase:
            return (97...122).map { String(UnicodeScalar($0)) }.joined()
        case .specialCharacters:
            return [33...47, 58...64, 91...96, 123...126].flatMap { $0.map { String(UnicodeScalar($0)) } }.joined()
        }
    }
}

/// Represents the errors that can occur during password generation.
public enum RandomPasswordGeneratorError: LocalizedError, Equatable {
    case insufficientLength, emptyCharacterTypes, emptyCharacterSet, noAvailableCharactersForType(CharacterType)
    
    /// Returns a localized description of the error.
    public var errorDescription: String? {
        switch self {
        case .insufficientLength:
            return "Password length must be greater than or equal to the number of selected character types."
        case .emptyCharacterTypes:
            return "At least one character type must be selected for password generation."
        case .emptyCharacterSet:
            return "The character set for password generation is empty."
        case .noAvailableCharactersForType(let type):
            return "No available characters for the selected character type: \(type)."
        }
    }
}

/// Generates random passwords with specified length, character types, and excluded characters.
public struct RandomPasswordGenerator {
    let length: Int
    let characterTypes: Set<CharacterType>
    let excludedCharacters: Set<Character>?
    
    /// Creates a new random password generator.
    ///
    /// - Parameters:
    ///   - length: The length of the password to generate.
    ///   - characterTypes: The types of characters to include in the password.
    ///   - excludedCharacters: The characters to exclude from the password.
    public init(length: Int, characterTypes: Set<CharacterType>, excludedCharacters: String? = nil) {
        self.length = length
        self.characterTypes = characterTypes
        self.excludedCharacters = excludedCharacters.map(Set.init)
    }
    
    /// Generates a random password.
    ///
    /// - Returns: A random password string.
    /// - Throws: An error if the password cannot be generated.
    public func generate() throws -> String {
        guard length >= characterTypes.count else {
            throw RandomPasswordGeneratorError.insufficientLength
        }
        
        guard !characterTypes.isEmpty else {
            throw RandomPasswordGeneratorError.emptyCharacterTypes
        }
        
        let allCharacters = characterTypes.flatMap { $0.characters }
        let availableCharacters = excludedCharacters.map { Set(allCharacters).subtracting($0) } ?? Set(allCharacters)
        
        guard !availableCharacters.isEmpty else {
            throw RandomPasswordGeneratorError.emptyCharacterSet
        }
        
        var password = try generateCharactersFromTypes(using: availableCharacters)
        password.append(contentsOf: generateRandomCharacters(from: availableCharacters))
        
        return String(password.shuffled())
    }
    
    private func generateCharactersFromTypes(using availableCharacters: Set<Character>) throws -> [Character] {
        try characterTypes.compactMap { type in
            let characters = type.characters.filter { availableCharacters.contains($0)}
            guard !characters.isEmpty else {
                throw RandomPasswordGeneratorError.noAvailableCharactersForType(type)
            }
            
            return randomCharacter(from: characters)
        }
    }
    
    private func generateRandomCharacters(from availableCharacters: Set<Character>) -> [Character] {
        (characterTypes.count..<length).map { _ in randomCharacter(from: availableCharacters) }
    }
    
    private func randomCharacter<C: Collection>(from characters: C) -> C.Element {
        let randomIndex = Int.random(in: 0..<characters.count)
        return characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
    }
}
