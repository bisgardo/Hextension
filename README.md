# Hextension

Small zero-dependency Swift package that extends `Data` from `Foundation`
with methods for converting to and from
[hexadecimal/base16](https://en.wikipedia.org/wiki/Hexadecimal) representation.

The implementation is simple, performant, well tested, and ready for production use.

All platforms are supported with no version restriction.

## Methods

- `Data(hex:)`: Parse `Data` from hex string
- `Data.hex`: Encode `Data` object into hex string

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
