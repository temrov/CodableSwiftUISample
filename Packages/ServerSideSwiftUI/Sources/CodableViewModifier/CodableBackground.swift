//
//  CodableBackground.swift
//  
//
//  Created by Vadim Temnogrudov on 14.04.2023.
//

import SwiftUI

public struct CodableBackground: ViewModifier, Decodable {
    
    let view: CodableView
    
    public func body(content: Content) -> some View {
        content.background(ViewFactory.view(for: view))
    }
}
