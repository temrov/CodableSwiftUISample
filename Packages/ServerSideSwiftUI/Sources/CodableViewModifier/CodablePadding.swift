//
//  CodablePadding.swift
//  
//
//  Created by Vadim Temnogrudov on 14.04.2023.
//

import SwiftUI

public struct CodablePadding: ViewModifier, Decodable {
    let insets: EdgeInsets
    
    public func body(content: Content) -> some View {
        content.padding(insets)
    }
}

extension EdgeInsets: Decodable {
    enum Errors: Error {
        case invalidFormat
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let values = try container.decode([CGFloat].self)
        guard values.count == 4 else {
            throw Errors.invalidFormat
        }
        self.init(top: values[0], leading: values[1], bottom: values[2], trailing: values[3])
    }
    
    
}
