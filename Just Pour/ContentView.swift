//
//  ContentView.swift
//  Just Pour
//
//  Created by Wojtek Kmita on 08/02/2020.
//  Copyright © 2020 Wojtek Kmita. All rights reserved.
//

import SwiftUI

class pouringPhase: Identifiable {
    var ID: Int
    var bloom: Bool
    var waterPouring: Bool
    var waiting: Bool
    let time: CGFloat
    var description: String
    var active = false
    
    init(ID: Int, bloom: Bool,waterPouring: Bool, waiting: Bool, time: CGFloat, description: String) {
        self.ID = ID
        self.bloom = bloom
        self.waterPouring = waterPouring
        self.waiting = waiting
        self.time = time
        self.description = description
    }
}

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
    
    @State var totalTime: CGFloat = 0
    @State var lastStage: Bool = false
    @State var recipe: Array<pouringPhase>
    @State var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State var activeStage: Int = 1
    @State var activeStageTimer: CGFloat = 0
    
    var refreshFrequency: CGFloat = 0.05
    
    func setCircleColor(actionTime: CGFloat, bloom: Bool, waterPouring: Bool, waiting: Bool) -> Color {
        if (waterPouring == false || waiting == false) {
            return Color.green
        }
        else if (waterPouring == true && waiting == true && actionTime >= 0) {
            return Color.green
        } else if (waterPouring == true && waiting == true && actionTime < 0 && actionTime >= -30) {
            return Color.orange
        } else if (waterPouring == true && waiting == true && actionTime < -30) {
            return Color.red
        } else {
            return Color.green
        }
    }
    
    var body: some View {
        
        Section {
            VStack (spacing: 25.00) {
                
                ForEach(self.recipe) { recipeItem in
                    if recipeItem.ID == self.activeStage {
                        ProgressView(actionTime: self.activeStageTimer, actionTimeConstant: recipeItem.time, refreshFrequency: self.refreshFrequency, lastStage: recipeItem.waterPouring && recipeItem.waiting, circleColor: self.setCircleColor(actionTime: self.activeStageTimer, bloom: recipeItem.bloom, waterPouring: recipeItem.waterPouring, waiting: recipeItem.waiting))
                            .onAppear(perform: {
                                self.activeStageTimer = recipeItem.time
                                self.timer = Timer.publish(every: Double(self.refreshFrequency), on: .main, in: .common).autoconnect()
                            })
                            .onReceive(self.timer) { _ in
                                if self.activeStageTimer > 0 || (recipeItem.waterPouring == true && recipeItem.waiting == true) {
                                    self.activeStageTimer -= self.refreshFrequency
                                }
                                if (self.activeStageTimer < self.refreshFrequency && !(recipeItem.waterPouring == true && recipeItem.waiting == true)) {
                                    self.activeStage += 1
                                    self.activeStageTimer = 0
                                    self.timer = Timer.publish(every: Double(self.refreshFrequency), on: .main, in: .common).autoconnect()
                                }
                            }
                            Text("Pour the first batch of water").bold()
                    }
                }

                Text("Total brew time: \(Int(floor(totalTime)))").font(.caption)
                    .onAppear(perform: {
                        self.timer = Timer.publish(every: Double(floor(self.refreshFrequency)), on: .main, in: .common).autoconnect()
                        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
