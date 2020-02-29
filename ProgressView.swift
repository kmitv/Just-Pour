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
    var circleColor: Color
        
    @State private var showGreenWaves = true
    @State private var showOrangeWaves = false
    @State private var showRedWaves = false
    
    var body: some View {
    
        Section {
            if (lastStage == false) {
                VStack (spacing: 50.00) {
                    ZStack {
                        Circle()
                            .trim(from: 0, to: (CGFloat(actionTime/actionTimeConstant)))
                            .stroke(self.circleColor, lineWidth:2)
                            .frame(width: 100, height: 100)
                            .rotationEffect(Angle(degrees:-90.00))
                        Text("\(Int(ceil(actionTime)))").font(.system(size: 60))
                    }
                }
            } else if (lastStage == true) {
                VStack (spacing: 50.00) {
                    ZStack {
                        Circle()
                            .stroke(self.circleColor, lineWidth:2)
                            .frame(width: 100.00, height: 100.00)
                            .scaleEffect(showGreenWaves ? 0 : 1.5)
                            .opacity(showGreenWaves ? 1 : 0)
                            .onAppear() {
                                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false).speed(1)) {
                                    self.showGreenWaves.toggle()
                                }
                            }
                        Text("\(Int(ceil(abs(actionTime))))").font(.system(size: 60))
                    }
                }
            }
        }
    }
}
