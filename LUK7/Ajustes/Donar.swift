//
//  Donar.swift
//  LUK7
//
//  Created by Marlon De Jesus Milanes Rivero on 8/8/23.
//

import SwiftUI

struct Donar: View {
    @State private var showAlert = false // State variable for showing the alert
    
    var body: some View {
        VStack {
 
            CardViewDonar(number: "marlonrivero1999@gmail.com", currency: "ZELLE", showAlert: $showAlert)
            Spacer()
        }
        .navigationBarTitle("donate", displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("copied_key"),
                message: Text("donatemejs_key"),
                dismissButton: .default(Text("accept_key"))
            )
        }
    }
    
}

struct CardViewDonar: View {
    var number: String
    var currency: String
    @Binding var showAlert: Bool // Binding to control the alert
    
    var body: some View {
        VStack {
            HStack {
                Text(number)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    copyToClipboard(text: number) // Copy the card number
                    showAlert = true // Show the alert
                }) {
                    Image(systemName: "doc.on.doc")
                        .foregroundColor(.blue)
                }
            }
            HStack {
                Text(currency)
                    .font(.subheadline)
                Spacer()
            }
            Divider()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    func copyToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
}

struct Donar_Previews: PreviewProvider {
    static var previews: some View {
        Donar()
    }
}

