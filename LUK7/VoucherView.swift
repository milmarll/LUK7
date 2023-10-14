//
//  VoucherView.swift
//  LUK7
//
//  Created by Elier Ayala Bernal on 2023-10-13.
//

import SwiftUI
import CodeScanner

struct VoucherView: View {
    
    @AppStorage("voucher_code") private var code : String = ""
    @AppStorage("voucher_name") private var name: String = ""
    @State private var isPresented : Bool = false
    @State private var isShowBarcode : Bool = false
    
    var body: some View {
        NavigationView {
            List {
                if !name.isEmpty {
                    HStack {
                        Image(systemName: "person")
                        VStack {
                            Text("\(name)")
                        }
                    }
                }
                
                
                if !code.isEmpty {
                    Section {
                        VStack(alignment: .leading) {
                            Text("ID: \(code)")
                            Divider()
                            if let barcode = generateBarcode(from: code) {
                                Image(uiImage: barcode)
                                    .interpolation(.none)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    } footer: {
                        Text("voucher_mejs")
                    }
                }
            }
            .navigationTitle("Voucher")
            .toolbar {
                
                ToolbarItem {
                    Button(action: presentAlert) {
                        Label("edit_key", systemImage: "pencil.circle")
                            .labelStyle(.titleOnly)
                    }
                }
                
                ToolbarItem {
                    Button(action: presentBarCode) {
                        Label("Add voucher", systemImage: "barcode.viewfinder")
                        
                    }
                }
                
                ToolbarItem {
                    Button(action: clearCode) {
                        Label("Clear Code", systemImage: "trash")
                    }
                }
                
            }
            .sheet(isPresented: $isShowBarcode, content: {
                CodeScannerView(codeTypes: [.code128], simulatedData: "Paul Hudson") { response in
                    switch response {
                    case .success(let result):
                        print("Found code: \(result.string)")
                        code = result.string
                        isShowBarcode.toggle()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            })
            .alert("associate_key", isPresented: $isPresented) {
                TextField("associatename_key", text: $name)
            }
        }
    }
    
    private func presentAlert() {
        isPresented.toggle()
    }
    
    private func presentBarCode() {
        isShowBarcode.toggle()
    }
    
    private func clearCode() {
        code = ""
    }
}

#Preview {
    VoucherView()
}
