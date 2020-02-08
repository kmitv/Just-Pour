//
//  ContentView.swift
//  Just Pour
//
//  Created by Wojtek Kmita on 08/02/2020.
//  Copyright © 2020 Wojtek Kmita. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        

        Section {
            NavigationView {
              
                
                    
                    List {
                        NavigationLink(destination: DetailView()) {
                            Text("Detail")
                        }
                        NavigationLink(destination: DetailView()) {
                            Text("Hello World")
                        }
                        NavigationLink(destination: DetailView()) {
                            Text("Hello World")
                        }
                        NavigationLink(destination: DetailView()) {
                            Text("Hello World")
                        }
                        NavigationLink(destination: Text("Detail View")) {
                            Text("Hello World")
                        }
                    }
                    .frame(minWidth: 100.00, maxWidth: 100.00, minHeight: 300.0, maxHeight: .infinity)
                
            }
            
            
            }.frame(width: 300.00, alignment: .leading)

        }

    }

struct DetailView: View {
  let discipline = "ddddd"
  var body: some View {
    Section {
        Text("pepepepe")
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


