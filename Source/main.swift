//
//  main.swift
//  VIPCodeGenerator
//
//  Created by mac on 04/11/2016.
//  Copyright © 2016 mozharovsky. All rights reserved.
//

import Foundation

public struct ConfigKeys {
    public static let patternPath = "Pattern path"
    public static let outputPath = "Output path"
    public static let generatorConfig = "GeneratorConfig"
    public static let name = "Name"
    public static let author = "Author"
    public static let date = "Date"
    public static let projectName = "Project name"
    public static let creator = "Creator"
}

public struct Placeholder {
    public static let name = "__NAME__"
    public static let author = "__AUTHOR__"
    public static let date = "__DATE__"
    public static let projectName = "__PROJECT_NAME__"
    public static let creator = "__CREATOR__"
}

public struct Config {
    public let name: String
    public let author: String // who owns the project
    public let date: String
    public let projectName: String
    public let creator: String // who created the file
}

public struct PatternFile {
    static let viewController = "__NAME__ViewController.swift"
    static let interactor = "__NAME__Interactor.swift"
    static let presenter = "__NAME__Presenter.swift"
    static let model = "__NAME__Model.swift"
    static let configurator = "__NAME__Configurator.swift"
    static let router = "__NAME__Router.swift"
    static let worker = "__NAME__Worker.swift"
}

//
// MARK: Loading config
//

let currentDirectory = CommandLine.arguments[1]

let configURL = URL(fileURLWithPath: currentDirectory + "/Config.plist")
let configDict = NSDictionary(contentsOf: configURL)!
let generatorDict = configDict[ConfigKeys.generatorConfig] as! NSDictionary

let formatter = DateFormatter()
formatter.dateFormat = "MM/dd/yyyy"
let date = formatter.string(from: Date())

let _configDate = (generatorDict[ConfigKeys.date] as? String) ?? ""
let configDate = _configDate.characters.count == 0 ? date : _configDate

let config = Config(
    name: (generatorDict[ConfigKeys.name] as? String) ?? "",
    author: (generatorDict[ConfigKeys.author] as? String) ?? "",
    date: configDate,
    projectName: (generatorDict[ConfigKeys.projectName] as? String) ?? "",
    creator: (generatorDict[ConfigKeys.creator] as? String) ?? ""
)


let patternPath = currentDirectory + "/" + ((configDict[ConfigKeys.patternPath] as? String) ?? "")
let outputPath = currentDirectory + "/" + ((configDict[ConfigKeys.outputPath] as? String) ?? "")

//
// MARK: Pattern URLs
//

let viewControllerURL = URL(fileURLWithPath: patternPath.appending("/\(PatternFile.viewController)"), isDirectory: false)
let interactorURL = URL(fileURLWithPath: patternPath.appending("/\(PatternFile.interactor)"), isDirectory: false)
let presenterURL = URL(fileURLWithPath: patternPath.appending("/\(PatternFile.presenter)"), isDirectory: false)
let modelURL = URL(fileURLWithPath: patternPath.appending("/\(PatternFile.model)"), isDirectory: false)
let configuratorURL = URL(fileURLWithPath: patternPath.appending("/\(PatternFile.configurator)"), isDirectory: false)
let routerURL = URL(fileURLWithPath: patternPath.appending("/\(PatternFile.router)"), isDirectory: false)
let workerURL = URL(fileURLWithPath: patternPath.appending("/\(PatternFile.worker)"), isDirectory: false)

//
// MARK: Contents' strings
//

let viewControllerString = try? String(contentsOf: viewControllerURL, encoding: String.Encoding.utf8)
let interactorString = try? String(contentsOf: interactorURL, encoding: String.Encoding.utf8)
let presenterString = try? String(contentsOf: presenterURL, encoding: String.Encoding.utf8)
let modelString = try? String(contentsOf: modelURL, encoding: String.Encoding.utf8)
let configuratorString = try? String(contentsOf: configuratorURL, encoding: String.Encoding.utf8)
let routerString = try? String(contentsOf: routerURL, encoding: String.Encoding.utf8)
let workerString = try? String(contentsOf: workerURL, encoding: String.Encoding.utf8)

//
// MARK: Processing
//

func processing(string: String?, config: Config) -> String? {
    return string?
        .replacingOccurrences(of: Placeholder.name, with: config.name)
        .replacingOccurrences(of: Placeholder.author, with: config.author)
        .replacingOccurrences(of: Placeholder.date, with: config.date)
        .replacingOccurrences(of: Placeholder.projectName, with: config.projectName)
        .replacingOccurrences(of: Placeholder.creator, with: config.creator)
}

//
// MARK: Output URLs
//

let viewControllerOutputURL = URL(fileURLWithPath: outputPath.appending("/\(config.name)/\(PatternFile.viewController.replacingOccurrences(of: Placeholder.name, with: config.name))"), isDirectory: false)
let interactorOutputURL = URL(fileURLWithPath: outputPath.appending("/\(config.name)/\(PatternFile.interactor.replacingOccurrences(of: Placeholder.name, with: config.name))"), isDirectory: true)
let presenterOutputURL = URL(fileURLWithPath: outputPath.appending("/\(config.name)/\(PatternFile.presenter.replacingOccurrences(of: Placeholder.name, with: config.name))"), isDirectory: true)
let modelOutputURL = URL(fileURLWithPath: outputPath.appending("/\(config.name)/\(PatternFile.model.replacingOccurrences(of: Placeholder.name, with: config.name))"), isDirectory: false)
let configuratorOutputURL = URL(fileURLWithPath: outputPath.appending("/\(config.name)/\(PatternFile.configurator.replacingOccurrences(of: Placeholder.name, with: config.name))"), isDirectory: true)
let routerOutputURL = URL(fileURLWithPath: outputPath.appending("/\(config.name)/\(PatternFile.router.replacingOccurrences(of: Placeholder.name, with: config.name))"), isDirectory: true)
let workerOutputURL = URL(fileURLWithPath: outputPath.appending("/\(config.name)/\(PatternFile.worker.replacingOccurrences(of: Placeholder.name, with: config.name))"), isDirectory: true)

//
// MARK: Writing to files
//

try? FileManager.default.createDirectory(atPath: outputPath + "/\(config.name)", withIntermediateDirectories: false, attributes: nil)

try? processing(string: viewControllerString, config: config)?.write(to: viewControllerOutputURL, atomically: true, encoding: String.Encoding.utf8)
try? processing(string: interactorString, config: config)?.write(to: interactorOutputURL, atomically: true, encoding: String.Encoding.utf8)
try? processing(string: presenterString, config: config)?.write(to: presenterOutputURL, atomically: true, encoding: String.Encoding.utf8)
try? processing(string: modelString, config: config)?.write(to: modelOutputURL, atomically: true, encoding: String.Encoding.utf8)
try? processing(string: configuratorString, config: config)?.write(to: configuratorOutputURL, atomically: true, encoding: String.Encoding.utf8)
try? processing(string: routerString, config: config)?.write(to: routerOutputURL, atomically: true, encoding: String.Encoding.utf8)
try? processing(string: workerString, config: config)?.write(to: workerOutputURL, atomically: true, encoding: String.Encoding.utf8)
