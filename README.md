# CobeDependencyInjection

Library for dependency injection using property wrappers

## Prerequisites
- Xcode 14.1 or later
- iOS 15.0 or later

## Installation
Using Package Manager:
```
    dependencies: [
    .package(url: "https://github.com/cobeisfresh/CobeDependencyInjection", .upToNextMajor(from: "1.0.0"))
]
```

## Usage
```
    protocol: SomeProtocol {}
    class: SomeServiceImplementation: SomeProtocol {}
    // register
    DependencyContainer.register(type: SomeProtocol.self, {
          PersistenceService()
      }())
     // use
    @Dependency var service: SomeProtocol
 ```
