//
//  DependencyContainer.swift
//  Vodafone_IVAP
//
//  Created by Mladen Ivastinovic on 01.09.2022..
//

import Foundation
import Network

final class DependencyContainer {

    private static var cache: [String: Any] = [:]
    private static var factoryDict: [String: () -> Any] = [:]

    static func registerSingleton<Service>(type: Service.Type, _ factory: @autoclosure @escaping () -> Service) {
        register(dependencyType: .singleton, type: type, factory())
    }

    static func register<Service>(dependencyType: DependencyType = .automatic,
                                  type: Service.Type, _ factory: @autoclosure @escaping () -> Service) {
        factoryDict[String(describing: type.self)] = factory
        switch dependencyType {
        case .singleton:
            cache[String(describing: type.self)] = factory()
        case .newInstance, .automatic:
            break
        }
    }

    static func resolve<Service>(dependencyType: DependencyType, _ type: Service.Type) -> Service? {
        switch dependencyType {
        case .singleton:
            if let cachedService = cache[String(describing: type.self)] as? Service {
                return cachedService
            } else {
                fatalError("\(String(describing: type.self)) is not registered as singleton")
            }
        case .automatic:
            if let cachedService = cache[String(describing: type.self)] as? Service {
                return cachedService
            }
            fallthrough
        case .newInstance:
            if let service = factoryDict[String(describing: type.self)]?() as? Service {
                cache[String(describing: type.self)] = service
                return service
            } else {
                return nil
            }
        }
    }
}