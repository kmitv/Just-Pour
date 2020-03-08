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

class pouroverMethod: Identifiable {
    var id: Int
    var name: String
    var description: String
    var picture: String
    
    init(id: Int, name: String, description: String, picture: String) {
        self.id = id
        self.name = name
        self.description = description
        self.picture = picture
    }
}

struct ContentView: View {
    
    let pouroverMethodList = [
        pouroverMethod(id: 1, name: "V60", description: "V60 is a pour-over cone made of plastic, ceramic, metal, or glass. It is produced by Hario, a Japanese company.", picture:"v60_icon"),
        pouroverMethod(id: 2, name: "Aeropress", description: "The AeroPress is a device for brewing coffee. It was invented in 2005 by Aerobie president Alan Adler. Coffee is steeped for 10–50 seconds and then forced through a filter by pressing the plunger through the tube.", picture:"aeropress_icon"),
        pouroverMethod(id: 3, name: "Chemex", description: "The Chemex Coffeemaker is a manual pour-over style glass coffeemaker. The thicker paper of the Chemex filters removes most of the coffee oils and makes coffee that is much \"cleaner\" than coffee brewed in other coffee-making systems.", picture:"chemex_icon"),
        pouroverMethod(id: 4, name: "Kalita Wave", description: "The Kalita Wave has a flat bed with three little holes at the bottom; this shape allows for an even and stable extraction.  ", picture:"kalita_icon")
    ]
    
    func disableLink(method: pouroverMethod) -> Bool {
        if(method.name != "V60"){
            return true
        } else {
            return false
        }
    }
    
    @State var selection: Int? = nil

    var body: some View {
        Section {
            NavigationView {
                List(pouroverMethodList, selection: self.$selection) { method in
                    NavigationLink(destination: DetailView(methodName: method.name, methodDescription: method.description, methodPicture: method.picture), tag: method.id, selection: self.$selection) {
                        
                        Text(method.name)
                            .onAppear() {
                            self.selection = 1
                        }
                        
                    }
                    .disabled(self.disableLink(method: method))
                }
                .frame(minWidth: 150.00, maxWidth: 150.00, minHeight: 500.0, maxHeight: .infinity).listStyle(SidebarListStyle()).padding(.top, 30.00)
                
                WelcomeScreenView()
                
            }
        }.frame(minWidth: 650.00, maxWidth: 650.00, minHeight: 500.00, maxHeight: 500.00, alignment: .leading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
