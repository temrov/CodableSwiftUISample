import Foundation
import SwiftUI

public struct CodableList: View, CodableViewVariant {
    
    public var id: UUID
    public var cells: [CodableView]
    
    public var body: some View {
        List {
            ForEach(cells, id: \.id) {
                ViewFactory.view(for: $0)
            }
        }
    }
}
