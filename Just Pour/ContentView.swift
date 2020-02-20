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
    
    func disableLink(method: pouroverMethod) -> Bool {
        if(method.name != "V60"){
            return true
        } else {
            return false
        }
    }

    var body: some View {
        Section {
            NavigationView {
                List(pouroverMethodList) { method in
                    NavigationLink(destination: DetailView(methodName: method.name, methodDescription: method.description, methodPicture: method.picture)) {
                        Text(method.name)
                    }.disabled(self.disableLink(method: method))
                }
                .frame(minWidth: 150.00, maxWidth: 150.00, minHeight: 300.0, maxHeight: .infinity).listStyle(SidebarListStyle())
            }
        }.frame(minWidth: 650.00, maxWidth: 650.00, minHeight:500.00, maxHeight: 500.00, alignment: .leading)
    }
}

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var bloomPourTime: CGFloat = 10
    @State var bloomPourTimeConstant: CGFloat = 10
    
    @State var bloomTime: CGFloat = 45
    @State var bloomTimeConstant: CGFloat = 45
    
    @State var totalTime: CGFloat = 0
    
    @State var bloomPourFinished: Bool = false
    @State var bloomWaitFinished: Bool = false
    
    var refreshFrequency: CGFloat = 0.05

    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        Section {
            VStack (spacing: 25.00) {
                
                if self.bloomPourFinished == false {
                    ProgressView(actionTime: bloomPourTime, actionTimeConstant: bloomPourTimeConstant, refreshFrequency: refreshFrequency)
                        .onAppear(perform: {
                            self.timer = Timer.publish(every: Double(self.refreshFrequency), on: .main, in: .common).autoconnect()
                        })
                        .onReceive(timer) { _ in
                            if self.bloomPourTime > 0 && self.bloomPourFinished == false {
                                self.bloomPourTime -= self.refreshFrequency
                                print(self.bloomPourTime)
                            } else if (self.bloomPourTime < 0) {
                                self.bloomPourFinished = true
                                self.timer = Timer.publish(every: Double(self.refreshFrequency), on: .main, in: .common).autoconnect()
                            }
                        }
                    Text("Pour the first batch of water").bold()
                }
                
                if self.bloomPourFinished == true && self.bloomWaitFinished == false {
                    
                    ProgressView(actionTime: bloomTime, actionTimeConstant: bloomTimeConstant, refreshFrequency: refreshFrequency)
                        .onAppear(perform: {
                            self.timer = Timer.publish(every: Double(self.refreshFrequency), on: .main, in: .common).autoconnect()
                        })
                        .onReceive(timer) { _ in
                            if self.bloomTime > 0 && self.bloomPourFinished == true && self.bloomWaitFinished == false {
                                self.bloomTime -= self.refreshFrequency
                            } else if (self.bloomTime < 0) {
                                self.bloomWaitFinished = true
                                self.timer = Timer.publish(every: Double(self.refreshFrequency), on: .main, in: .common).autoconnect()
                            }
                        }
                    Text("Wait for your coffee to bloom").bold()
                }

                Text("Total brew time: \(Int(totalTime))").font(.caption)
                    .onAppear(perform: {
                        self.timer = Timer.publish(every: Double(self.refreshFrequency), on: .main, in: .common).autoconnect()
                        
                    })
                    .onReceive(timer) { _ in
                        self.totalTime += self.refreshFrequency
                    }
                
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()

                }) {
                    Text("Cancel")
                }
            }
        }.frame(width: 300.00, height: 250.00).padding(20.00)
        
    }
}

struct DetailView: View {
    
    @State private var radioSelection = 1
    
    @State private var amount: Int = 15
    @State private var water: Int = 234
    @State private var ratio: Int = 18
    
    @State private var amountActive: Bool = true
    @State private var waterActive: Bool = true
    @State private var ratioActive: Bool = false

    @State var showSheetView = false
    
    var methodName: String
    var methodDescription: String
    var methodPicture: String
    
    func disableIfActive(activeIndex: Int, selected: Int) -> Bool {
        if(activeIndex==selected){
            return true
        } else {
            return false
        }
    }
    
    func amountUpdated(amount: Int, water: Int, ratio: Int, selection: Int) -> Void {
        if(selection==2) {
            self.ratio = water / amount
        }
        if(selection==3) {
            self.water = amount * ratio
        }
    }
    
    func waterUpdated(amount: Int, water: Int, ratio: Int, selection: Int) -> Void {
        if(selection==1) {
            self.ratio = water / amount
        }
        if(selection==3) {
            self.amount = water / ratio
        }
    }
    
    func ratioUpdated(amount: Int, water: Int, ratio: Int, selection: Int) -> Void {
        if(selection==1) {
            self.water = amount * ratio
        }
        if(selection==2) {
            self.amount = water / ratio
        }
    }
    
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
                Picker(selection: $radioSelection, label: EmptyView()) {
                    
                    Stepper(onIncrement: {
                        self.amount += 1
                        self.amountUpdated(amount: self.amount, water: self.water, ratio: self.ratio, selection: self.radioSelection)
                    }, onDecrement: {
                        self.amount -= 1
                        self.amountUpdated(amount: self.amount, water: self.water, ratio: self.ratio, selection: self.radioSelection)
                    }, label: { Text("Coffee amount:  \(amount) g")}
                    ).tag(1).disabled(disableIfActive(activeIndex: 1, selected: radioSelection))
                    
                    Stepper(onIncrement: {
                        self.water += 1
                        self.waterUpdated(amount: self.amount, water: self.water, ratio: self.ratio, selection: self.radioSelection)
                    }, onDecrement: {
                        self.water -= 1
                        self.waterUpdated(amount: self.amount, water: self.water, ratio: self.ratio, selection: self.radioSelection)
                    }, label: { Text("Water:  \(water) ml")}
                    ).tag(2).disabled(disableIfActive(activeIndex: 2, selected: radioSelection))
                    
                    Stepper(onIncrement: {
                        self.ratio += 1
                        self.ratioUpdated(amount: self.amount, water: self.water, ratio: self.ratio, selection: self.radioSelection)
                    }, onDecrement: {
                        self.ratio -= 1
                        self.ratioUpdated(amount: self.amount, water: self.water, ratio: self.ratio, selection: self.radioSelection)
                    }, label: { Text("Coffee to water ratio:  \(ratio) g/ml")}
                    ).tag(3).disabled(disableIfActive(activeIndex: 3, selected: radioSelection))
                    
                }.pickerStyle(RadioGroupPickerStyle())
                
                
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Text("Start brewing")
                }.sheet(isPresented: $showSheetView) {
                    SheetView()
                }
                
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
