//
//  ContentView.swift
//  CodableSwiftUISample
//
//  Created by Vadim Temnogrudov on 11.04.2023.
//

import SwiftUI
import ServerSideSwiftUI

class LocalJSONFileSource: ObservableObject {
    @Published var codableView: CodableView?
    
    private let fileMonitor: FileMonitor
    private let pathURL: URL
    
    init() {
        let filePath = Bundle.main.path(forResource: "Screen", ofType: "json")!
        self.pathURL = URL(filePath: filePath)
        self.fileMonitor = FileMonitor(url: pathURL)
        
        fileMonitor.fileDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshJSON()
            }
        }
        
        fileMonitor.startMonitoring()
        refreshJSON()
    }
    
    func refreshJSON() {
        do {
            codableView = try JSONDecoder().decode(CodableView.self, from: Data(contentsOf: pathURL))
        } catch {
            print(error)
        }
    }
}


struct ContentView: View {
    @StateObject var localJSONFileSource = LocalJSONFileSource()

    var body: some View {
        if let codableView = localJSONFileSource.codableView {
            ViewFactory.view(for: codableView)
        } else {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
