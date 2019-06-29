//
//  Field.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 22/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

internal class Field: GraphQLNode {

    let name: String
    let arguments: GraphArgument?
    var selectionSet: SelectionSet?

    init(name: String, arguments: GraphArgument?, selectionSet: SelectionSet?) {
        self.name = name
        self.arguments = arguments
        self.selectionSet = selectionSet
    }

    override func toString(format: PrintFormat, previousLevel: Int) -> String {
        var selectionSetPart = ""
        if let selectionSet = selectionSet?.toString(format: format, previousLevel: previousLevel) {
            selectionSetPart = " \(selectionSet)"
        }

        var argumentsPart = ""
        if let arguments = arguments?.toString(format: format, previousLevel: previousLevel) {
            argumentsPart = " \(arguments)"
        }

        return "\(name)\(argumentsPart)\(selectionSetPart)"
    }

}
