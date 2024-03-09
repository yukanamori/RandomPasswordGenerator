# RandomPasswordGenerator

[![build](https://github.com/yukanamori/RandomPasswordGenerator/actions/workflows/main.yml/badge.svg)](https://github.com/yukanamori/RandomPasswordGenerator/actions/workflows/main.yml)
[![Swift Version Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fyukanamori%2FRandomPasswordGenerator%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/yukanamori/RandomPasswordGenerator)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fyukanamori%2FRandomPasswordGenerator%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/yukanamori/RandomPasswordGenerator)

RandomPasswordGenerator is a Swift library for generating random passwords with specified length, character types, and excluded characters.

## Features

- Generate random passwords of a specified length.
- Include or exclude specific types of characters (digits, uppercase, lowercase, special characters). Special characters refer to non-space symbols in the ASCII code.
- Exclude specific characters from the generated password.

## Installation

This library can be installed using the Swift Package Manager. To do so, add the following to your Package.swift file:

```swift
dependencies: [
    .package(url: "https://github.com/yukanamori/RandomPasswordGenerator", from: "0.1.0")
]
```

## Usage

```swift
import Foundation

// Create a new password generator
let generator = RandomPasswordGenerator(length: 10, characterTypes: [.digits, .uppercase, .lowercase])

do {
    // Generate a random password
    let password = try generator.generate()
    print(password)
} catch {
    print("An error occurred: \(error)")
}
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
