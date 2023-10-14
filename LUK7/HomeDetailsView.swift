//
//  HomeDetailsView.swift
//  LUK7
//
//  Created by Elier Ayala Bernal on 2023-10-12.
//

import SwiftUI
import CodeScanner
import CoreImage.CIFilterBuiltins

struct HomeDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)], animation: .default) private var items: FetchedResults<Item>


    @State var item: Item
    @State private var isShowBarcode: Bool = false
    
    var body: some View {
        List {
            Section {
                EmptyView()
            }
            
            if let init_code = item.init_code {
                Section {
                    VStack(alignment: .leading) {
                        Text("\(init_code)")
                        Divider()
                        if let barcode = generateBarcode(from: init_code) {
                            Image(uiImage: barcode)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                } footer: {
                    Text("home_mejs")
                }
            }
            
            if let end_code = item.end_code {
                Section {
                    VStack(alignment: .leading) {
                        Text("\(end_code)")
                        Divider()
                        if let barcode = generateBarcode(from: end_code) {
                            Image(uiImage: barcode)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
            
            if let init_code_calc = item.init_code, let end_code_calc = item.end_code {
                Section {
                    EmptyView()
                } header: {
                    Text("Total LPN: \(restarUltimosCuatroDigitos(init_code_calc, end_code_calc))")
                }
            }
        }
        .listStyle(.insetGrouped)
        .toolbar {
            ToolbarItem {
                Button(action: showScan) {
                    Label("Scan barcode", systemImage: "barcode.viewfinder")
                }
            }
        }
        .navigationTitle("LPN \(item.timestamp!, formatter: itemFormatter)")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowBarcode, content: {
            CodeScannerView(codeTypes: [.code128], simulatedData: "Paul Hudson") { response in
                switch response {
                case .success(let result):
                    print("Found code: \(result.string)")
                    
                    if item.init_code == nil {
                        editItem(newItemValue: result.string, type: .init_code, timestamp: item.timestamp!)
                    } else {
                        editItem(newItemValue: result.string, type: .end_code, timestamp: item.timestamp!)
                    }
                   
                    
                    isShowBarcode.toggle()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        })
    }
        
    private func showScan() {
        isShowBarcode.toggle()
    }
    
    private func editItem(newItemValue: String, type: TypeCode, timestamp: Date) {
        withAnimation {
            do {
                if let item = items.first(where: { $0.timestamp == timestamp }) {
                    switch type {
                    case .init_code:
                        item.init_code = newItemValue
                    case .end_code:
                        item.end_code = newItemValue
                    }
                }
                
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    
    enum TypeCode: Int {
        case init_code = 0
        case end_code = 1
    }
}

extension View {

    func generateBarcode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.code128BarcodeGenerator()
        let data = Data(string.utf8)
        filter.message = data

        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        } else {
            return nil
        }
    }
    
    func restarUltimosCuatroDigitos(_ str1: String, _ str2: String) -> String {
        let index1 = str1.index(str1.endIndex, offsetBy: -4)
        let index2 = str2.index(str2.endIndex, offsetBy: -4)

        let lastFourDigitsStr1 = str1[index1...]
        let lastFourDigitsStr2 = str2[index2...]

        if let num1 = Int(lastFourDigitsStr1), let num2 = Int(lastFourDigitsStr2) {
            let result = num2 - num1
            return String(result)
        } else {
            return "home_error"
        }
    }


}
