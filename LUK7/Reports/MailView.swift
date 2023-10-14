//
//  SwiftUIView.swift
//  LUK7
//
//  Created by Marlon Milanes Rivero on 2023-08-07.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isShowing: Bool

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = context.coordinator
        mailController.setToRecipients(["marlonrivero1999@gmail.com"])
        mailController.setSubject("mail_subjet")
        mailController.setMessageBody(getDeviceInfo(), isHTML: false)
        return mailController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func getDeviceInfo() -> String {
        var body = "\n\n\n\n\n\n\n\n"
        
        let deviceName = UIDevice.current.localizedModel
        body.append(contentsOf: deviceName)
        
        let iosVersion = "iOS Version: \(UIDevice.current.systemVersion)"
        body.append(iosVersion)
        
        if let appVersion  = UIApplication.appVersion {
            body.append("\nLUK7 Version: \(appVersion)")
        }
        if let buildVersion = UIApplication.buildVersion {
            body.append("\nLUK7 Build: \(buildVersion)")
        }
        return body
        
    }
    
    func getModelName() -> String? {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
             case "iPhone8,1":    return "iPhone 6s"
             case "iPhone8,2":    return "iPhone 6s Plus"
             case "iPhone8,4":    return "iPhone SE (1st generation)"
             case "iPhone9,1":    return "iPhone 7"
             case "iPhone9,2":    return "iPhone 7 Plus"
             case "iPhone9,3":    return "iPhone 7"
             case "iPhone9,4":    return "iPhone 7 Plus"
             case "iPhone10,1":   return "iPhone 8"
             case "iPhone10,2":   return "iPhone 8 Plus"
             case "iPhone10,3":   return "iPhone X"
             case "iPhone10,4":   return "iPhone 8"
             case "iPhone10,5":   return "iPhone 8 Plus"
             case "iPhone10,6":   return "iPhone X"
             case "iPhone11,2":   return "iPhone XS"
             case "iPhone11,4":   return "iPhone XS Max"
             case "iPhone11,6":   return "iPhone XS Max (China)"
             case "iPhone11,8":   return "iPhone XR"
             case "iPhone12,1":   return "iPhone 11"
             case "iPhone12,3":   return "iPhone 11 Pro"
             case "iPhone12,5":   return "iPhone 11 Pro Max"
             case "iPhone12,8":   return "iPhone SE (2nd generation)"
             case "iPhone13,1":   return "iPhone 12 mini"
             case "iPhone13,2":   return "iPhone 12"
             case "iPhone13,3":   return "iPhone 12 Pro"
             case "iPhone13,4":   return "iPhone 12 Pro Max"
             default:             return nil
             }
         }
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailView
        
        init(_ parent: MailView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
