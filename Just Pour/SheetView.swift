//
//  SheetView.swift
//  Just Pour
//
//  Created by Wojtek Kmita on 29/02/2020.
//  Copyright © 2020 Wojtek Kmita. All rights reserved.
//

import SwiftUI

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
