//
//  Variables.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 22/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

internal class Variables: GraphQLNode {

    var variables = [String: GraphVariable]()

    override func toString(format: PrintFormat, previousLevel: Int) -> String {
        return
            "{" +
                variables.map { "\($0.key): \($0.value.jsonValue)" }
                    .joined(separator: ",") +
            "}"
    }

    var isEmpty: Bool { return variables.isEmpty }

    func asArgument() -> GraphArgument? {
        if !isEmpty {
            var x = [String: GraphVariableType]()
            _ = variables.values.map { x[$0.dollarName] = $0.type }
            return GraphArgument(args: x)
        }
        return nil
    }

}
