//
//  DependencyContainer.swift
//  Vodafone_IVAP
//
//  Created by Mladen Ivastinovic on 01.09.2022..
//

import Foundation
import Network

public final class DependencyContainer {

    private static var cache: [String: Any] = [:]
    private static var factoryDict: [String: () -> Any] = [:]

    public static func registerSingleton<Service>(type: Service.Type, _ factory: @autoclosure @escaping () -> Service) {
        register(dependencyType: .singleInstance, type: type, factory())
    }

    public static func register<Service>(dependencyType: DependencyType = .automatic,
                                  type: Service.Type, _ factory: @autoclosure @escaping () -> Service) {
        factoryDict[String(describing: type.self)] = factory
        switch dependencyType {
        case .singleInstance:
            cache[String(describing: type.self)] = factory()
        case .newInstance, .automatic:
            break
        }
    }

    public static func resolve<Service>(dependencyType: DependencyType, _ type: Service.Type) -> Service? {
        switch dependencyType {
        case .singleInstance:
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
