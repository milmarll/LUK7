//
//  LUK7App.swift
//  LUK7
//
//  Created by Marlon Milanes Rivero on 10/12/23.
//

import SwiftUI

@main
struct LUK7App: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("colorSchemeSelection") private var colorSchemeSelection = 0
    @AppStorage("isNotCheckedTerms") var isNotCheckedTerms = true

    var body: some Scene {
        WindowGroup {
            Group {
                SplashScreenContent()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)

            }.preferredColorScheme(getAppColorScheme())
                .sheet(isPresented: $isNotCheckedTerms, content: {
                    TermsView()
                })
        }
    }

    private func getAppColorScheme() -> ColorScheme? {
        switch colorSchemeSelection {
        case 0:
            return .dark
        case 1:
            return .light
        default:
            return nil // Modo automático
        }
    }
}
