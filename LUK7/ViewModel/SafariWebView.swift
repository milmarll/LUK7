//
//  SafariViewController.swift
//  LUK7
//
//  Created by Marlon Milanes Rivero on 10/26/23.
//

import Foundation
import SwiftUI
import SafariServices

struct SafariWebView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
