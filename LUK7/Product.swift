//
//  Product.swift
//  LUK7
//
//  Created by Marlon Milanes Rivero on 11/3/23.
//
import SwiftUI


struct Product: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: []) var report: FetchedResults<Report>
    @State private var search: String = ""
    @State private var isNew: Bool = false
    @State private var isCopyAlertPresented: Bool = false
    @State var tempName: String = ""
    @State var tempTarjetas: String = ""
    
    @Environment(\.editMode)  var mode

    var body: some View {
        VStack {
            Form {
                ForEach(report.filter { search.isEmpty || $0.name!.localizedCaseInsensitiveContains(search) }, id: \.id) { report in
                    
                    HStack {
                        Image("Card1")
                            .resizable()
                            .frame(width: 50, height: 35)
                        
                        Button {
                            copyToClipboard(text: report.report ?? "0")
                            isCopyAlertPresented = true
                        } label : {
                            VStack(alignment: .leading) {
                                Text(report.name ?? "Unknown")
                                Text(report.report.report ?? "0")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.secondary)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .onDelete(perform: deleteReport)
                
            }
            .navigationTitle("Mis Tarjetas")
            .searchable(text: $search, prompt: "Buscar")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        tempName = ""
                        tempTarjetas = ""
                        isNew.toggle()
                    } label: {
                        Text("Agregar")
                    }
                }
                
            }
            .alert("Detalles de la tarjeta", isPresented: $isNew) {
                TextField("Nombre", text: $tempName)
                TextField("No. de tarjeta", text: $tempTarjetas)
                
                Button("Ok", action: {
                    
                    if tempName.isEmpty || tempTarjetas.isEmpty {
                        return
                    }
                    addReport()
                    isNew.toggle()
                })
                
                Button("Cancel", role: .cancel) {
                    isNew.toggle() // Cierra el alert sin hacer nada
                }
            } message: {
                Text("Verifica y llena la información de tu tarjeta")
            }
            .alert("Tarjeta Copiada", isPresented: $isCopyAlertPresented) {
                        Button("OK", role: .cancel) {
                            isCopyAlertPresented = false // Oculta el alert al presionar OK
                        }
                    }
            
        }
    
    }
    

    func addReport() {
        withAnimation {
            let report = Report(context: viewContext)
            report.id = UUID()
            report.name = self.tempName
            report.report  = self.tempTarjetas

            saveContext()
        }
    }
    
    func editReport(report: Report, newName: String, newReport: String) {
        withAnimation {
            report.name = newName
            report.report  = newReport
            saveContext()
        }
    }

    func copyToClipboard(text: String) {
            UIPasteboard.general.string = text
    }

    private func deleteReport(offsets: IndexSet) {
        withAnimation {
            offsets.map { report[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }

    }
}
#Preview {
    Product()
}
