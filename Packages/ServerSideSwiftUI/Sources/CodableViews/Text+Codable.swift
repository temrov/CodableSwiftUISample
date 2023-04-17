import Foundation
import SwiftUI

public struct CodableText: View, CodableViewVariant {
    
    
    var alignment: TextAlignment
    var content: String
    var lineLimit: Int?
    var fontSize: CGFloat?

    
    public var body: some View {
        Text(content)
            .lineLimit(lineLimit)
            .multilineTextAlignment(alignment)
            .font(.system(size: fontSize ?? 14))
    }
}
