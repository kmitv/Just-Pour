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
    
    var lastStage: Bool
    
    func zeroIfNegative(actionTime: CGFloat) -> CGFloat {
        if(actionTime < 0){
            return 0
        } else {
            return actionTime
        }
    }
    
    var body: some View {
    

        Section {
            if (lastStage == false) {
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
            } else {
                VStack (spacing: 50.00) {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .scaleEffect(1-CGFloat(self.zeroIfNegative(actionTime: actionTime)/actionTimeConstant))
                            .frame(width: 100, height: 100)
                        Text("\(Int(ceil(abs(actionTime))))").font(.system(size: 60))
                    }
                }
            }
        }
        
        
    }
}
