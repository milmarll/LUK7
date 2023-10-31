//
//  Ajustes.swift
//  LUK7
//
//  Created by Marlon De Jesus Milanes Rivero on 8/3/23.
//

import SwiftUI
import MessageUI
import SafariServices

struct Ajustes: View {
    
    @State private var isShowingMailView = false
    @AppStorage("colorSchemeSelection") private var colorSchemeSelection = 0
    @State private var isSheetPresented = false
    
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
            
            Section(header: Text("setting_share")) {
                Button(action: {
                    shareApp()
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .renderingMode(.original)
                        Text("setting_APP")
                            .foregroundColor(.primary)
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
                
                Button(action: {
                    self.isSheetPresented.toggle()
                }) {
                    HStack {
                        Image(systemName: "safari")
                        Text("Website")
                            .foregroundColor(.primary)
                    }
                }
                .sheet(isPresented: $isSheetPresented) {
                    WebViewSheet(url: URL(string: "https://innovapp-soft.blogspot.com/p/inicio.html")!)
                }
                
            }
            
        }
    }
    
    private func shareApp() {
        let textToShare = "setting_mensj"
        if let myWebsite = URL(string: "https://apps.apple.com/us/app/luk7/id6469251484?l=es-MX") {
            let objectsToShare: [Any] = [textToShare, myWebsite]
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
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

struct WebViewSheet: View {
    let url: URL

    var body: some View {
        NavigationView {
            SafariWebView(url: url)
               
        }
    }
}




