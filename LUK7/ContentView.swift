//
//  ContentView.swift
//  LUK7
//
//  Created by Marlon Milanes Rivero on 10/12/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("home_home", systemImage: "house") }
                .environment(\.managedObjectContext, viewContext)
            
            VoucherView().tabItem { Label("Voucher", systemImage: "person") }
            
            Ajustes()
                .tabItem { Label("home_gear", systemImage: "gear") }
            
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
             
}
