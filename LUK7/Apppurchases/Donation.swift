//
//  TransferPayPremium.swift
//  TransferPay
//
//  Created by Marlon De Jesus Milanes Rivero on 8/22/23.
//
import SwiftUI
import Lottie


struct TransferPayPremium: View {
    @State private var isChecked = true // Estado del checkmark
    @State private var isSubscribed = false // Estado de la suscripción
    @State private var buttonOffset: CGFloat = 0.0
    @State private var showMessage = false // Estado para mostrar el mensaje
    
    struct Option: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let iconName: String
    }
    
    let options: [Option] = [
        Option(title: "Lenguaje", description: "Selecciona tu idioma preferido.", iconName: "globe"),
        Option(title: "Sin anuncios", description: "Navega sin interrupciones publicitarias.", iconName: "nosign"),
        Option(title: "Tarjetas", description: "Guarda tus tarjetas de forma segura y conveniente.", iconName: "creditcard"),
        Option(title: "VIP", description: "Acceso anticipado a funciones VIP y exclusivas.", iconName: "star"),
    ]
    
    var body: some View {
        ZStack{
            
            VStack{
                
                VStack{
                    
                    LottieView(animationName: "premium")
                        .frame(minHeight: 30,maxHeight: 30)
                        .padding()
                        .padding(.bottom)
                        .padding(.top)
                        
                    Text("TransferPay Premium")
                        .font(.system(size: 24, weight: .bold)) // Tamaño mediano y en negrita
                        .padding(.top, 10) // Espaciado en la parte superior

                    Text("Supera los límites, obtén funciones exclusivas y ¡apóyanos suscribiéndote a Premium!")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                
                formView()
                
                
                Button(action: {
                    withAnimation {
                        isSubscribed.toggle()
                        showMessage = true
                    }
                }) {
                    Text("Suscríbete por $2.99")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .padding()
                
            }
            .navigationBarTitle("Premium", displayMode: .inline)
            .alert(isPresented: $showMessage) {
                Alert(
                    title: Text("Próximamente"),
                    message: Text("Esta función será implementada próximamente."),
                    dismissButton: .default(Text("Aceptar"))
                )
            }
        }
          
        
    }
    
    
    @ViewBuilder
    private func formView() -> some View {
        
        Form {
            List {
                
                Section {
                    HStack {
                        Button(action: {
                            isChecked.toggle()
                        }) {
                            Image(systemName: (isChecked) ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor((isChecked) ? .blue : .gray)
                                .font(.system(size: 20, weight: .bold, design: .default))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Anual")
                                .foregroundColor(.primary)
        
                        }
                        
                        Spacer()
                        Text("$2.99")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Funciones"), footer: Text("TransferPay Premium nos permite cubrir gastos como cuenta desarrollador de Apple, Internet, entre otros, y también nos ayuda a que siga siendo gratuito para todos.")) {
                    ForEach(options, id: \.id) { option in
                        HStack {
                            Image(systemName: option.iconName)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text(option.title)
                                    .foregroundColor(.primary)
                                
                                Text(option.description)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    
                }
                .listStyle(InsetGroupedListStyle())
                
                
            }
        }
    }
}

struct TransferPayPremium_Previews: PreviewProvider {
    static var previews: some View {
        TransferPayPremium()
    }
}

//Lottie

struct LottieView: UIViewRepresentable {
    
    var animationName: String
    
    func makeUIView(context: Context) -> LottieAnimationView{
        
        let view = LottieAnimationView(name: animationName, bundle: Bundle.main)
        view.loopMode = .loop
        view.play()
        
        return view
        
    }
    
    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        
    }
}


