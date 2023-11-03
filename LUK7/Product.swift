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
    @State private var selectedReport: Report?
    @State private var showingDetailSheet = false

    var body: some View {
        NavigationView {
            Form {
                ForEach(report.filter { search.isEmpty || $0.name!.localizedCaseInsensitiveContains(search) }, id: \.id) { report in
                    
                    HStack {
                        Image(systemName: "wrench.and.screwdriver")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Button {
                            self.selectedReport = report
                        } label : {
                            VStack(alignment: .leading) {
                                Text(report.name ?? "Unknown")
                                Text(report.report ?? "0")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.secondary)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        HStack {
                            
                            if let date = report.createdAt {
                                Text(date, formatter: itemFormatter)
                                    .font(.footnote)
                            } else {
                                Text("report_fecha")
                                    .font(.footnote)
                            }
                        }
                        
                    }
                    
                }
                .onDelete(perform: deleteReport)
                
            }
            .navigationTitle("report_title")
            .searchable(text: $search, prompt: "report_look")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        tempName = ""
                        tempTarjetas = ""
                        isNew.toggle()
                    } label: {
                        Text("report_add")
                    }
                }
                
            }
            .alert("report_details", isPresented: $isNew) {
                TextField("report_title_textfield", text: $tempName)
                TextField("report_message", text: $tempTarjetas)
                
                Button("Ok", action: {
                    
                    if tempName.isEmpty || tempTarjetas.isEmpty {
                        return
                    }
                    addReport()
                    isNew.toggle()
                })
                
                Button("Cancel", role: .cancel) {
                    isNew.toggle()
                }
            } message: {
                Text("report_message_textfield")
            }
            .sheet(item: $selectedReport) { report in
                ReportDetailView(report: report, closeAction: {
                    self.selectedReport = nil
                })
            }
            .overlay(alignment: .bottom) {
                HStack {
                    BannerAd(unitID: "ca-app-pub-4020019088912260/6506320758")
                        .frame(minHeight: 50, maxHeight: 50)
                }
            }
        
        
        }
        
    }
    
    func addReport() {
            withAnimation {
                let newReport = Report(context: viewContext)
                newReport.id = UUID()
                newReport.name = self.tempName
                newReport.report = self.tempTarjetas
                newReport.createdAt = Date()
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
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

struct ReportDetailView: View {
    let report: Report
    let closeAction: () -> Void

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                // Título
                HStack {
                    Text(report.name ?? "No Title")
                        .font(.largeTitle) // Título con fuente grande
                        .bold()
                    Spacer()
                    Button("Done", action: closeAction) // Botón de cerrar
                        .font(.headline) // Botón con fuente destacada
                }

                Divider()

                // Mensaje
                Text(report.report ?? "No Content")
                    .font(.body) // Mensaje con fuente del cuerpo

                Spacer()

                // Fecha y hora
                if let createdAt = report.createdAt {
                    Text(createdAt, formatter: itemFormatter)
                        .font(.footnote) // Fecha con fuente pequeña
                        .frame(maxWidth: .infinity, alignment: .trailing) // Alineado a la derecha
                }
            }
            .padding()
            .navigationBarHidden(true) // Ocultamos la barra de navegación para utilizar nuestro propio botón
        }
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}


#Preview {
    Product()        
}


