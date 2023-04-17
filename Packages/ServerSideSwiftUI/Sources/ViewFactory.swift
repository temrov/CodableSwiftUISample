//
//  ViewFactory.swift
//  My360iDevApp
//
//  Created by Florian Harr on 8/21/21.
//

import Foundation
import SwiftUI

public struct ViewFactory {
    @ViewBuilder
    public static func view(for codableView: CodableView) -> some View {
        switch codableView {
        case let .list(view, modifiers):
            applyViewModifiers(view: view, modifiers: modifiers)
        case let .text(view, modifiers):
            applyViewModifiers(view: view, modifiers: modifiers)
        case let .button(view, modifiers):
            applyViewModifiers(view: view, modifiers: modifiers)
        case let .image(view, modifiers):
            applyViewModifiers(view: view, modifiers: modifiers)
        case let .vStack(view, modifiers):
            applyViewModifiers(view: view, modifiers: modifiers)
        case let .hStack(view, modifiers):
            applyViewModifiers(view: view, modifiers: modifiers)
        case let .color(view, modifiers):
            applyViewModifiers(view: view, modifiers: modifiers)
        }
    }
    
    @ViewBuilder
    private static func applyViewModifiers<Content: View>(view: Content, modifiers: [CodableViewModifier]) -> some View {
        view.modifier(RecursiveViewModifier(modifiers: modifiers))
    }
}

struct RecursiveViewModifier: ViewModifier {
    let modifiers: [CodableViewModifier]
    
    func body(content: Content) -> some View {
        if modifiers.isEmpty {
            content
        } else {
            var modifiers = modifiers
            let firstModifier = modifiers.remove(at: 0)
            firstModifier.applyModifier(content: content)
                .modifier(RecursiveViewModifier(modifiers: modifiers))
        }
    }
}
