//
//  Acerca.swift
//  LUK7
//
//  Created by Marlon De Jesus Milanes Rivero on 8/4/23.
//

import SwiftUI

struct Acerca: View {
    var body: some View {
        VStack {
            Form {
                
                ProfileHeader()
                    .frame(maxWidth: .infinity)
                
            }
        }
        .navigationBarTitle("titledesa", displayMode: .inline)
    }
}

struct ProfileHeader: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("marlon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Text("Marlon Milanes Rivero")
                .font(.headline)
                .lineLimit(1)
            
            Text("developercreator")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("FC Associate I, L1")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Link("@milmarll", destination: URL(string: "https://apps.apple.com/us/app/amazon-a-to-z/id1413909063?l=es-MX")!)
                .font(.system(size: 14, weight: .medium))
        }
        .padding()
    }
}

struct DeveloperRow: View {
    var name: String
    var icon: String
    var link: String
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            Text(name)
            Spacer()
            Link(destination: URL(string: link)!, label: {
                Image(systemName: "arrow.right.circle")
            })
        }
    }
}

struct Acerca_Previews: PreviewProvider {
    static var previews: some View {
        Acerca()
    }
}

