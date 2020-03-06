//
//  DetailView.swift
//  Just Pour
//
//  Created by Wojtek Kmita on 29/02/2020.
//  Copyright © 2020 Wojtek Kmita. All rights reserved.
//

import SwiftUI

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
    
    let defaultRecipe = [
        pouringPhase(ID: 1, bloom: true, waterPouring: true, waiting: false, time: 5.00, description: "jeden"),
        pouringPhase(ID: 2, bloom: true, waterPouring: false, waiting: true, time: 5.00, description: "dwa"),
        pouringPhase(ID: 3, bloom: false, waterPouring: true, waiting: true, time: 5.00, description: "trzy")
    ]
    
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
                    SheetView(recipe: self.defaultRecipe)
                }
                
            }.frame(minWidth: 100.00, maxWidth: .infinity, maxHeight: .infinity).padding(.horizontal, 100.0)
        }
        .padding(.top, 20.0)
    }
}
