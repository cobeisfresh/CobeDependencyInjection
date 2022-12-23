//
//  DependencyPropertyWrapper.swift
//  Vodafone_IVAP
//
//  Created by Mladen Ivastinovic on 01.09.2022..
//

import Foundation

@propertyWrapper
struct Dependency<Service> {

    var service: Service

    init(_ dependencyType: DependencyType = .automatic) {
        guard let service = DependencyContainer.resolve(dependencyType: dependencyType, Service.self) else {
            fatalError("No dependency of type \(String(describing: Service.self)) registered!")
        }

        self.service = service
    }

    var wrappedValue: Service {
        get { self.service }
        mutating set { service = newValue }
    }
}
