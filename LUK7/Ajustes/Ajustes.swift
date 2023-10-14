//
//  Ajustes.swift
//  TransferPay
//
//  Created by Marlon De Jesus Milanes Rivero on 8/3/23.
//

import SwiftUI
import MessageUI

struct Ajustes: View {
    
    @State private var isShowingMailView = false
    @AppStorage("colorSchemeSelection") private var colorSchemeSelection = 0

    var body: some View {

        NavigationView(content: {
            formView()
                .navigationTitle("home_gear")
        }).navigationViewStyle(.stack)
        
    }
    
    @ViewBuilder
    func formView() -> some View {
        Form {
            Section(header: Text("info")) {
                NavigationLink(destination: Acerca()) {
                    HStack {
                        Image(systemName: "scribble")
                            .renderingMode(.original)
                        Text("titledesa")
                            .foregroundColor(.primary)
                    }
                    
                }
                
                NavigationLink(destination: Donar()) {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                            .renderingMode(.original)
                        Text("donate")
                            .foregroundColor(.primary)
                    }
                    
                }
                
                HStack {
                    Image(systemName: "info.circle")
                        .renderingMode(.original)
                    Text("version")
                        .foregroundColor(.primary)
                    Spacer()
                    if let appVersion = UIApplication.appVersion {
                        Text(appVersion)
                            .foregroundColor(.gray)
                    }
                }
            }
            Section(header: Text("appearance")) {
                Picker(selection: $colorSchemeSelection, label: Text("Modo de Color")) {
                    Text("dark").tag(0)
                    Text("ligth").tag(1)
                    Text("auto").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: colorSchemeSelection) { _ in
                    setAppColorScheme()
                }
                
                
            }
    
            Section(header: Text("support_key")) {
                Button(action: {
                    isShowingMailView.toggle()
                }) {
                    HStack {
                        Image(systemName: "ladybug.fill")
                            .renderingMode(.original)
                        Text("report")
                            .foregroundColor(.primary)
                    }
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailView(isShowing: $isShowingMailView)
                }
                
                
            }
        }
    }
    private func setAppColorScheme() {
        switch colorSchemeSelection {
        case 0:
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .forEach { scene in
                    scene.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .dark
                    }
                }
        case 1:
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .forEach { scene in
                    scene.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .light
                    }
                }
        case 2:
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .forEach { scene in
                    scene.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .unspecified
                    }
                }
        default:
            break
        }
    }

}

struct Ajustes_Previews: PreviewProvider {
    static var previews: some View {
        Ajustes()
    }
}





