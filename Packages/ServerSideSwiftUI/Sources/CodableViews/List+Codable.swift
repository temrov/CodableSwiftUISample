import Foundation
import SwiftUI

public struct CodableList: View, CodableViewVariant {
    
    public var cells: [CodableView]
    
    public var body: some View {
        List {
            ForEach(cells.indices, id: \.self) {
                ViewFactory.view(for: cells[$0])
            }
        }
    }
}
