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
        pouroverMethod(name: "V60", description: "ememememe", picture:"jajajajajaj/sddsdsd"),
        pouroverMethod(name: "Aeropress", description: "AEROPREEEES", picture:"jajajajajaj/sddsdsd"),
        pouroverMethod(name: "Chemex", description: "TO WIELKI DZBAN", picture:"jajajajajaj/sddsdsd"),
        pouroverMethod(name: "Gabi", description: "TO BRZMI JAK DAMSKIE IMIĘ", picture:"jajajajajaj/sddsdsd")
    ]

    var body: some View {
        Section {
            NavigationView {
                List(pouroverMethodList) { method in
                    NavigationLink(destination: DetailView(methodName: method.name, methodDescription: method.description, methodPicture: method.picture)) {
                        Text(method.name)
                    }
                }
                .frame(minWidth: 100.00, maxWidth: 100.00, minHeight: 300.0, maxHeight: .infinity)
            }
        }.frame(minWidth: 500.00, maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

struct DetailView: View {
    var methodName: String
    var methodDescription: String
    var methodPicture: String
    
    var body: some View {
        Section {
            Text(methodDescription)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


