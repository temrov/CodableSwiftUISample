import Foundation
import SwiftUI

public struct CodableButton: View, CodableViewVariant {
    
    var content: String

    public var body: some View {
        Button(content) {
            print("\(content) pressed")
        }
    }
}
