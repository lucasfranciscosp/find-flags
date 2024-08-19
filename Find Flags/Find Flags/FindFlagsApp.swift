//
//  Find_FlagsApp.swift
//  Find Flags
//
//  Created by Lucas Francisco on 01/08/24.
//

import SwiftUI

@main
struct Find_FlagsApp: App {
    
    @AppStorage("hasOnboardingCompleted") private var hasOnboardingCompleted = false
    
    @State private var isPresentingOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                EntryView()
                    .sheet(
                        isPresented: Binding<Bool>(
                            get: {
                                !hasOnboardingCompleted },
                            set: { _ in }
                        ),
                        
                        content: {
                            OnboardingView(
                                onboardingCompleted: $hasOnboardingCompleted
                            ).interactiveDismissDisabled()
                        })
                    .onAppear {
                        isPresentingOnboarding = true
                    }.accentColor(.customAccentColor)
            }
        }
    }
}
