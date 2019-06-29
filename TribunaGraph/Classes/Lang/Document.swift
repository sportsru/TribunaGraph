//
//  Document.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 22/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

internal class Document: GraphQLNode {

    let operation: Operation
    let variables: Variables

    init(operation: Operation, variables: Variables) {
        self.operation = operation
        self.variables = variables
    }

    override func toString(format: PrintFormat, previousLevel: Int) -> String {
        let operationNamePart = operation.name.map { "\"\($0)\"" }

        var variablesPart: String?
        if !variables.isEmpty {
            variablesPart = variables.toString(format: .json, previousLevel: previousLevel)
        }
        // swiftlint:disable line_length
        return "{\"query\": \"\(operation.toString(format: PrintFormat.json, previousLevel: previousLevel))\", \"variables\": \(String(describing: variablesPart)), \"operationName\": \(String(describing: operationNamePart))}"
    }

}
