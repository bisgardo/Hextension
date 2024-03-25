# Hextension

Small zero-dependency Swift package that extends `Data` from `Foundation`
with methods for converting to and from
[hexadecimal/Base16](https://en.wikipedia.org/wiki/Hexadecimal) representation.

The implementation is simple, performant, well tested, and ready for production use.

All platforms are supported without version restriction.

## Features

The library extends the standard `Data` type with the following members:

- `Data(hex:)` initializer: Parse `Data` from hex string or throw error if it's invalid.
- `Data.hex` property: Encode `Data` object into a hex string.

*Aliases:*

For consistency with the existing support for Base64, the following aliases are included as well:

- `Data(base16Encoded:)` initializer: Same as `Data(hex:)` except that it will return `nil` on invalid input
  instead of throwing an error.
- `Data.base16EncodedString()` method: Same as the `Data.hex`.

## Usage

To use the library in a SwiftPM project, add it as a package dependency
and include it into the appropriate target in `Package.swift`:

```swift
// ...
let package = Package(
    // ...,
    dependencies: [
        // ...,
        .package(url: "https://github.com/bisgardo/Hextension.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            // ...,
            dependencies: [
                // ...,
                "Hextension",
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

Note that it's sufficient to import the package in just a single source file of the project.
So it might make sense to only do so in a special file like `Hextension.swift` or `Extensions/Data+Hex.swift`
which contains just this import.
