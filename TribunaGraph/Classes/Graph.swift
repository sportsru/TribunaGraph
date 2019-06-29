//
//  Graph.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 23/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

public typealias FieldBlock = (Graph.FieldBuilder) -> Void
typealias CursorBlock = (Graph.CursorSelectionBuilder) -> Void
typealias NodeBlock = (Graph.NodeBuilder) -> Void

public class Graph {

    // MARK: - Properties
    private var document: Document!
    internal static var variables: Variables = Variables()

    // MARK: - Init
    public init(builder: (Graph) -> Void) {
        builder(self)
    }

    // MARK: - Functions
    public func request(type: OperationType, name: String? = nil, _ builder: FieldBlock) {
        guard let set = try? Graph.createSelectionSet(type.rawValue, fieldBlock: builder) else {
            return
        }
        let operation = Operation(type: type,
                                  selectionSet: set,
                                  name: name,
                                  arguments: Graph.variables.asArgument())
        document = Document(operation: operation,
                            variables: Graph.variables)
    }

    static func createSelectionSet(_ name: String, fieldBlock: FieldBlock) throws -> SelectionSet {
        let fieldBuilder = FieldBuilder()
        fieldBlock(fieldBuilder)

        let set = SelectionSet(fields: fieldBuilder.fields)
        if set.fields.isEmpty {
            throw Exception.noFieldsInSelectionSet("No field elements inside \"\(name)\" block")
        }
        return set
    }

    func toGraphQueryString() -> String {
        return document.operation.toString(format: .pretty, previousLevel: 0)
    }

    func toRequestString() -> String {
        return document.toString(format: .json, previousLevel: 0)
    }

    public var queryString: String {
        return document.operation.toString(format: .normal, previousLevel: 0)
    }

    func requestVariableString() -> String {
        return document.variables.toString(format: .json, previousLevel: 0)
    }

    func requestOperationName() -> String? {
        return document.operation.name
    }

    public class FieldBuilder {
        var fields = [Field]()

        public func fieldObject(_ name: String, args: [String: Any]? = nil, builder: @escaping FieldBlock) {
            addField(name: name, args: args, builder: builder)
        }

        public func field(_ name: String, args: [String: Any]? = nil, builder: FieldBlock? = nil) {
            addField(name: name, args: args, builder: builder)
        }

        public func fragment(name: String) throws {
            guard let fragment = fragments[name] else {
                throw Exception.noSuchFragment("No fragment named \"\(name)\" has been defined.")
            }

            fragment(self)
        }

        func variable(name: String, type: String, jsonValue: String) -> GraphVariable {
            let variable = GraphVariable(name: name, type: GraphVariableType(value: type), jsonValue: jsonValue)
            variables.variables[name] = variable

            return variable
        }

        func cursorConnection(name: String,
                              first: Int = -1,
                              last: Int = -1,
                              before: String? = nil,
                              after: String? = nil,
                              builder: CursorBlock) throws {
            var argsMap = [String: Any]()

            if first != -1 {
                argsMap["first"] = first
            }
            if last != -1 {
                argsMap["last"] = last
            }
            if let before = before {
                argsMap["before"] = before
            }
            if let after = after {
                argsMap["after"] = after
            }

            if argsMap.isEmpty {
                throw Exception.illegalArgument("There must be at least 1 argument for Cursor Connection")
            }

            let selection = CursorSelectionBuilder()
            builder(selection)

            let cursorConnection = CursorConnection(name: name,
                                                    argument: GraphArgument(args: argsMap),
                                                    selectionSet: SelectionSet(fields: selection.fields))
            fields.append(cursorConnection)
        }

        private func addField(name: String, args: [String: Any]? = nil, builder: FieldBlock? = nil) {

            var argNode: GraphArgument?
            if let args = args {
                argNode = GraphArgument(args: args)
            }

            var selectionSet: SelectionSet?
            if let builder = builder {
                selectionSet = try? createSelectionSet(name, fieldBlock: builder)
            }

            let field = Field(name: name, arguments: argNode, selectionSet: selectionSet)
            fields.append(field)
        }

    }

    class CursorSelectionBuilder: FieldBuilder {

        func edges(builder: NodeBlock) throws {
            let node = NodeBuilder()
            builder(node)

            guard let selectionSet = node.selectionSet else {
                throw Exception.cannotCreate("Cannot create selection set")
            }

            let edges = Edges(nodeSelectionSet: selectionSet, additionalField: node.fields)
            fields.append(edges)
        }

        func pageInfo(fieldBuilder: (FieldBuilder) -> Void) throws {
            guard let pageSelection = try? createSelectionSet("pageInfo", fieldBlock: fieldBuilder) else {
                throw Exception.cannotCreate("Cannot create page selection")
            }

            let array = ["hasNextPage", "hasPreviousPage"]
            let names = pageSelection.fields.map { $0.name }
            let isNameFound = array.map { names.contains($0) }.reduce(false) { $0 || $1 }
            // swiftlint:disable line_length
            if !isNameFound {
                throw Exception.noFieldsInSelectionSet("Selection Set must contain hasNextPage and/or hasPreviousPage field")
            }

            let pageInfo = GraphCursorPageInfo(pageSelectionSet: pageSelection)
            fields.append(pageInfo)
        }

    }

    class NodeBuilder: FieldBuilder {

        var selectionSet: SelectionSet?

        func node(builder: (FieldBuilder) -> Void) {
            selectionSet = try? createSelectionSet("node", fieldBlock: builder)
        }

    }

    private static var fragments: [String: FieldBlock] = [:]

    func defineFragment(name: String, builder: @escaping FieldBlock) {
        Graph.fragments[name] = builder
    }

}
