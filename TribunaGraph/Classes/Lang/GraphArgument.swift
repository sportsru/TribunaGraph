//
//  GraphArgument.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 22/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

class GraphArgument: GraphQLNode {

    let args: [String: Any]

    init(args: [String: Any] = [:]) {
        self.args = args
    }

    override func toString(format: PrintFormat, previousLevel: Int) -> String {
        return "(\(print(value: args, format: format)))"
    }

}
