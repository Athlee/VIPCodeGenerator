# VIPCodeGenerator

<p align="center">
  <img src ="https://raw.githubusercontent.com/Athlee/VIPCodeGenerator/master/Assets/logo.png" />
</p>

### Requirements
- Swift 3 

# Usage

## Configuration

`VIPCodeGenerator` uses `Config.plist` file for getting configuration values. 

`Config` is declared as follows:

```swift
public struct Config {
    public let name: String
    public let author: String // who owns the project
    public let date: String
    public let projectName: String
    public let creator: String // who created the file
}
```

Use the `GeneratorConfig` dictionary to add values. 

```php
<key>GeneratorConfig</key>
<dict>
<key>Name</key>
<string>__NAME__</string>
<key>Author</key>
<string>__AUTHOR__</string>
<key>Date</key>
<string></string>
<key>Project name</key>
<string>__PROJECT_NAME__</string>
<key>Creator</key>
<string>__CREATOR__</string>
</dict>
```

> Note: if `Date` string is empty, generator will use current date as default.

## Path

Please, note, that `VIPCodeGenerator` is being run via command line tools (`generate.sh` script handles it). It uses `args[1]` as the path where `/Pattern` and `/Output` folders are located (these ones can actually have other names). 

## Patterns

`VIPCodeGenerator` uses patterns with the following identifiers: 

```swift 
public struct PatternFile {
    static let viewController = "__NAME__ViewController.swift"
    static let interactor = "__NAME__Interactor.swift"
    static let presenter = "__NAME__Presenter.swift"
    static let model = "__NAME__Model.swift"
    static let configurator = "__NAME__Configurator.swift"
    static let router = "__NAME__Router.swift"
}
```

Standard ones are located in the `/Pattern` folder. You can change these by changing the patterns' path in `Config.plist`.

```php
	<key>Pattern path</key>
	<string>Pattern</string>
```

## Output

Generated code is generally expected to be generated within `/Output` folder but you can easily change that path.

```
-----Desktop
----VIPCodeGenerator
---Source
--Output
-`__NAME__`
```

## Usage

To generate the code all you have to do is to run a script `generate.sh` that is located within `Source` folder. Nothing more. ;]

# Community
* For help & feedback please use [issues](https://github.com/Athlee/VIPCodeGenerator/issues).
* Got a new feature? Please submit a [pull request](https://github.com/Athlee/VIPCodeGenerator/pulls).
* Email us with urgent queries. 

# License
`VIPCodeGenerator` is available under the MIT license, see the [LICENSE](https://github.com/Athlee/VIPCodeGenerator/blob/master/LICENSE) file for more information.
