//
//  ProgressView.swift
//  Just Pour
//
//  Created by Wojtek Kmita on 20/02/2020.
//  Copyright © 2020 Wojtek Kmita. All rights reserved.
//

import SwiftUI

struct ProgressView: View {
    
    var actionTime: CGFloat
    let actionTimeConstant: CGFloat
    var refreshFrequency: CGFloat
    var lastStage: Bool
        
    @State private var showGreenWaves = false
    @State private var showOrangeWaves = false
    @State private var showRedWaves = false
    
    func zeroIfNegative(actionTime: CGFloat) -> CGFloat {
        if(actionTime < 0){
            return 0
        } else {
            return actionTime
        }
    }
    
    func waveColor(actionTime: CGFloat) -> Color {
        if(actionTime > 0){
            return .blue
        } else {
            return .red
        }
    }
    
    var body: some View {
    
        Section {
            if (lastStage == false) {
                VStack (spacing: 50.00) {
                    ZStack {
                        Circle()
                            .trim(from: 0, to: (CGFloat(actionTime/actionTimeConstant)))
                            .stroke(Color.green, lineWidth:2)
                            .frame(width: 100, height: 100)
                            .rotationEffect(Angle(degrees:-90.00))
                        Text("\(Int(ceil(actionTime)))").font(.system(size: 60))
                    }
                }
            } else if (lastStage == true && actionTime >= 0) {
                VStack (spacing: 50.00) {
                    ZStack {
                        Circle()
                            .stroke(Color.green, lineWidth:2)
                            .frame(width: 100.00, height: 100.00)
                            .scaleEffect(showGreenWaves ? 1.5 : 1)
                            .opacity(showGreenWaves ? 0 : 1)
                            .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false).speed(1))
                            .onAppear() {
                                self.showGreenWaves.toggle()
                        }
                        Text("\(Int(ceil(abs(actionTime))))").font(.system(size: 60))
                    }
                }
            } else if (lastStage == true && actionTime < 0 && actionTime > -30) {
                VStack (spacing: 50.00) {
                    ZStack {
                        Circle()
                            .stroke(Color.orange, lineWidth:2)
                            .frame(width: 100.00, height: 100.00)
                            .scaleEffect(showOrangeWaves ? 1.5 : 1)
                            .opacity(showOrangeWaves ? 0 : 1)
                            .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false).speed(1))
                            .onAppear() {
                                self.showOrangeWaves.toggle()
                        }
                        Text("\(Int(ceil(abs(actionTime))))").font(.system(size: 60))
                    }
                }
            } else if (lastStage == true && actionTime <= -30) {
                VStack (spacing: 50.00) {
                    ZStack {
                        Circle()
                            .stroke(Color.red, lineWidth:2)
                            .frame(width: 100.00, height: 100.00)
                            .scaleEffect(showRedWaves ? 1.5 : 1)
                            .opacity(showRedWaves ? 0 : 1)
                            .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false).speed(1))
                            .onAppear() {
                                self.showRedWaves.toggle()
                        }
                        Text("\(Int(ceil(abs(actionTime))))").font(.system(size: 60))
                    }
                }
            }
        }
    }
}
