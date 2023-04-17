import Foundation
import SwiftUI

public struct CodableText: View, CodableViewVariant {
    
    
    var alignment: TextAlignment
    var content: String
    var lineLimit: Int?

    
    public var body: some View {
        Text(content)
            .lineLimit(lineLimit)
            .multilineTextAlignment(alignment)
    }
}
