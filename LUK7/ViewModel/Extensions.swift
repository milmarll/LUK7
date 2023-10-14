//
//  Extensions.swift
//  LUK7
//
//  Created by Marlon Milanes Rivero on 11/13/2023.
//

import Foundation
import SwiftUI
import Combine

//MARK: - MailView.swift
extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    static var buildVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }

    static var hasSupportForUSSD: Bool {
        !UIDevice.current.systemVersion.contains("15.4") || !UIDevice.current.systemVersion.contains("16.0.1")
    }
}
//MARK: - end MailView.swift

//MARK: - AllView

extension Color {
    static let background = Color("BackgroundColor") // Cambia "BackgroundColor" al nombre de tu color de fondo
}

extension String {
    var urlEncoded: String {
        let allowedCharacterSet = CharacterSet.urlQueryAllowed
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)!
    }
}

func removeNonNumericCharacters(from string: String) -> String {
    var numericString = ""
    for character in string {
        if character.isNumber {
            numericString.append(character)
        } else if character != " " {
            // Append any non-space characters to the numeric string
            numericString.append(character)
        }
    }
    return numericString
}



extension Publishers {
    static var keyboardRect: AnyPublisher<Bool, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { _ in return true }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in return false}
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
extension Notification {
    var keyboardRect: CGRect {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) ?? .zero
    }
}

