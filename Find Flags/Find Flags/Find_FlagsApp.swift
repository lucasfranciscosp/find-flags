//
//  Find_FlagsApp.swift
//  Find Flags
//
//  Created by Lucas Francisco on 01/08/24.
//

import SwiftUI
import SwiftData

@main
struct Find_FlagsApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView(classifier: ImageClassifier())
            EntryView()
        }
        .modelContainer(for: DataItem.self)
    }
}
