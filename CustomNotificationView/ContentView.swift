//
//  ContentView.swift
//  CustomNotificationView
//
//  Created by Kalpesh on 28/02/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject private var topSheetVM = TopSheetViewModel(horizontalPadding: 0, backgroundColor: .red)

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Button("Show Top Sheet") {
                    topSheetVM.show(opacity: 0.3)
                }
                .padding()
            }.background(Color.blue.opacity(0.3))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(content: {
            if topSheetVM.isPresented {
                TopSheetView(viewModel: topSheetVM, content:  {
                    VStack {
                        Text("Full-Width Top Sheet")
                            .font(.title)
                            .padding()
                        
                        Text("This sheet takes up the full screen width and has no space above.")
                            .padding()
                        
                        Button("Dismiss") {
                            topSheetVM.hide()
                        }
                        .padding()
                    }
                })
                .transition(.move(edge: .top))
            }
        })
    }
}


#Preview {
    ContentView()
}
