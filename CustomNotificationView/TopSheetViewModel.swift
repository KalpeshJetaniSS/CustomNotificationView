//
//  TopSheetViewModel.swift
//  CustomNotificationView
//
//  Created by Kalpesh on 28/02/25.
//


import SwiftUI

class TopSheetViewModel: ObservableObject {
    @Published var sheetOffset: CGFloat = -UIScreen.main.bounds.height

    @Published private(set) var isPresented: Bool = false
    @Published private(set) var backgroundOpacity: Double = 0.0
    var horizontalPadding : CGFloat = 0
    var backgroundColor : Color = .white

    init(backgroundOpacity: Double = 0, horizontalPadding: CGFloat = 0, backgroundColor: Color = .white) {
        self.backgroundOpacity = backgroundOpacity
        self.horizontalPadding = horizontalPadding
        self.backgroundColor = backgroundColor
    }
    
    @MainActor
    func show(opacity: Double = 0.3) {
        DispatchQueue.main.async(qos: .userInteractive) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                self.sheetOffset = 0
                self.backgroundOpacity = opacity
            }
        }
        self.isPresented = true
    }
    @MainActor
    func hide() {
        DispatchQueue.main.async(qos: .userInteractive) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                self.sheetOffset = -UIScreen.main.bounds.height //  Sheet animates out
                self.backgroundOpacity = 0
            } completion: {
                self.isPresented = false
            }
        }
    }
}
