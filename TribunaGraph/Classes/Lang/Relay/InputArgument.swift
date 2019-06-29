//
//  InputArgument.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 23/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

internal class InputArgument: GraphArgument {

    override func toString(format: PrintFormat, previousLevel: Int) -> String {
        return "(input: { \(print(value: args, format: format)) })"
    }

}
