//
//  ContentView.swift
//  Just Pour
//
//  Created by Wojtek Kmita on 08/02/2020.
//  Copyright © 2020 Wojtek Kmita. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    class pouroverMethod: Identifiable {
        var name: String
        var description: String
        var picture: String
        
        init(name: String, description: String, picture: String) {
            self.name = name
            self.description = description
            self.picture = picture
        }
    }
    
    let pouroverMethodList = [
        pouroverMethod(name: "V60", description: "V60 is a pour-over cone made of plastic, ceramic, metal, or glass. It is produced by Hario, a Japanese company.", picture:"v60_icon"),
        pouroverMethod(name: "Aeropress", description: "The AeroPress is a device for brewing coffee. It was invented in 2005 by Aerobie president Alan Adler. Coffee is steeped for 10–50 seconds and then forced through a filter by pressing the plunger through the tube.", picture:"aeropress_icon"),
        pouroverMethod(name: "Chemex", description: "The Chemex Coffeemaker is a manual pour-over style glass coffeemaker. The thicker paper of the Chemex filters removes most of the coffee oils and makes coffee that is much \"cleaner\" than coffee brewed in other coffee-making systems.", picture:"chemex_icon"),
        pouroverMethod(name: "Kalita Wave", description: "The Kalita Wave has a flat bed with three little holes at the bottom; this shape allows for an even and stable extraction.  ", picture:"kalita_icon")
    ]

    var body: some View {
        Section {
            NavigationView {
                List(pouroverMethodList) { method in
                    NavigationLink(destination: DetailView(methodName: method.name, methodDescription: method.description, methodPicture: method.picture)) {
                        Text(method.name)
                    }
                }
                .frame(minWidth: 150.00, maxWidth: 150.00, minHeight: 300.0, maxHeight: .infinity).listStyle(SidebarListStyle())
            }
        }.frame(minWidth: 650.00, maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

struct DetailView: View {
    
    @State private var amount: Int = 15
    @State private var water: Int = 234
    @State private var ratio: Int = 18
    
    @State private var amountActive: Bool = true
    @State private var waterActive: Bool = true
    @State private var ratioActive: Bool = false
    
    var methodName: String
    var methodDescription: String
    var methodPicture: String
    
    var body: some View {
        
        VStack {
            Section {
                VStack(spacing: 20.0) {
                    VStack(alignment: .center) {
                        Image(methodPicture)
                            .resizable().frame(width: 64.0, height: 64.0)
                        Text(methodName)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    }
                    .frame(width: 100.00, height: 100.00)
                    .padding(.horizontal, 20.0)
                    .padding(.vertical, 10.0)
                    .background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .cornerRadius(15.00)
                    Text(methodDescription)
                        .frame(width: 400.00, height: 75.00)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 30.0)
            }.frame(minHeight: 250.00)
            Section {
                
                VStack {
                    
                    Toggle(isOn: $amountActive) {
                        Stepper(value: $amount, in: 0...500, label: { Text("Coffee amount:  \(amount) g")}).disabled(!amountActive)
                    }
                    Toggle(isOn: $waterActive) {
                        Stepper(value: $water, in: 0...500, label: { Text("Water:  \(water) ml")}).disabled(!waterActive)
                    }
                    Toggle(isOn: $ratioActive) {
                        Stepper(value: $ratio, in: 0...500, label: { Text("Ratio:  \(ratio) g/ml")}).disabled(!ratioActive)
                    }
                    
//                    Stepper(value: $amount, in: 0...500, label: { Text("Coffee amount:  \(amount) g")})
//                    Stepper(value: $water, in: 0...500, label: { Text("Water:  \(water) ml")})
//                    Stepper(value: $ratio, in: 0...500, label: { Text("Ratio:  \(ratio) g/ml")})
                }
                
                
//                TextField("Enter your name", text: $amount)
//                Text("Hello, \(amount)!")
                

                
            }.frame(minWidth: 100.00, maxWidth: .infinity, maxHeight: .infinity).padding(.horizontal, 100.0)
        }
        .padding(.top, 20.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


