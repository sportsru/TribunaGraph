//
//  Operation.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 22/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

internal class Operation: GraphQLNode {

    internal let type: OperationType
    internal let selectionSet: SelectionSet
    internal let name: String?
    internal let arguments: GraphArgument?

    init(type: OperationType, selectionSet: SelectionSet, name: String? = nil, arguments: GraphArgument? = nil) {
        self.type = type
        self.selectionSet = selectionSet
        self.name = name
        self.arguments = arguments
    }

    override func toString(format: PrintFormat, previousLevel: Int) -> String {
        var namePart = ""
        if let name = name {
            namePart = " \(name)"
        }

        var argumentPart = ""
        if let arguments = arguments?.toString(format: format, previousLevel: previousLevel) {
            argumentPart = " \(arguments)"
        }

        // swiftlint:disable line_length
        return "\(type)\(namePart)\(argumentPart) \(selectionSet.toString(format: format, previousLevel: previousLevel))"
    }

}

enum OperationType: String {
    case query
    case mutation
    case subscription
}
