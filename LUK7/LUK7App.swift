//
//  LUK7App.swift
//  LUK7
//
//  Created by Marlon Milanes Rivero on 10/12/23.
//

import SwiftUI
import FirebaseCore
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct LUK7App: App {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    let persistenceController = PersistenceController.shared
    @AppStorage("colorSchemeSelection") private var colorSchemeSelection = 0
    @AppStorage("isNotCheckedTerms") var isNotCheckedTerms = true
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

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
