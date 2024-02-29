# Hextension

Small zero-dependency Swift package that extends `Data` from `Foundation`
with methods for converting to and from
[hexadecimal/base16](https://en.wikipedia.org/wiki/Hexadecimal) representation.

The implementation is simple, performant, well tested, and ready for production use.

All platforms are supported with no version restriction.

## Methods

- `Data(hex:)` initializer: Parse `Data` from hex string (or throw error).
- `hex` property of `Data`: Encode `Data` object into hex string.

*Aliases:*

The following methods are included for consistency with the corresponding ones for Base64 in the standard library.

- `Data(base16Encoded:)` initializer: Same as `Data(hex:)` except that it will return `nil` on invalid input
  instead of throwing an error.
- `base16EncodedString` property of `Data`: Same as the `hex` property of `Data`.

## Usage

To use the library in a SwiftPM project, add it as a dependency and target in
`Package.swift`:

```swift
...
let package = Package(
    // ...,
    dependencies: [
        // ...,
        .package(url: "https://github.com/bisgardo/swift-hexsention.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            // ...,
            dependencies: [
                // ...,
                .product(name: "Hextension", package: "swift-hexsention"),
            ]
        ),
        // ...
    ]
)
```

The extension is now enabled by importing the package

```swift
import Hextension
```
