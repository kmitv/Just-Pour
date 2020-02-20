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
    var actionTimeConstant: CGFloat
    
    var refreshFrequency: CGFloat
    
    var body: some View {
    
        Section {
            VStack (spacing: 50.00) {
                ZStack {
                    Circle()
                    .trim(from: 0, to: (CGFloat(actionTime/actionTimeConstant)))
                    .stroke(Color.green, lineWidth:5)
                        .frame(width: 100, height: 100)
                        .rotationEffect(Angle(degrees:-90.00))
                    Text("\(Int(ceil(actionTime)))").font(.system(size: 60))
                }
            }
        }
    }
}
