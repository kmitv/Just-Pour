//
//  RecipeCreationPopup.swift
//  Just Pour
//
//  Created by Wojtek Kmita on 01/03/2020.
//  Copyright © 2020 Wojtek Kmita. All rights reserved.
//

import SwiftUI

struct RecipeCreationPopupView: View {
    
    @State var isViewVisible = true
    
    var body: some View {
        
        Section {
            if (isViewVisible == true) {
                VStack {
                    
                    Button(action: {
                        
                        
                        
                        app.stopModal()
                        self.isViewVisible = false
                        
                        
                        
                        
                    }) {
                            Text("Add mock data")
                        }
                    
                    
                    Button(action: {
                        app.stopModal()
                        self.isViewVisible = false
                        
                    }) {
                            Text("Close")
                        }
                    
                    
                    }
                }
            }
        }
}

struct RecipeCreationPopup_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCreationPopupView()
    }
}
