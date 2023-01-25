//
//  DependencyPropertyWrapper.swift
//  Vodafone_IVAP
//
//  Created by Mladen Ivastinovic on 01.09.2022..
//

import Foundation

@propertyWrapper
public struct Dependency<Service> {

    public var service: Service

    public init(_ dependencyType: DependencyType = .automatic) {
        guard let service = DependencyContainer.resolve(dependencyType: dependencyType, Service.self) else {
            fatalError("No dependency of type \(String(describing: Service.self)) registered!")
        }

        self.service = service
    }

    public var wrappedValue: Service {
        get { self.service }
        mutating set { service = newValue }
    }
}
