//
//  TopSheetView.swift
//  CustomNotificationView
//
//  Created by Kalpesh on 28/02/25.
//


import SwiftUI

struct TopSheetView<Content: View>: View {
    @ObservedObject var viewModel: TopSheetViewModel
    let content: () -> Content
    @GestureState private var dragOffset: CGFloat = 0 // Stores drag state

    var body: some View {
        if viewModel.isPresented {
            GeometryReader{ geometry in
                
                ZStack(alignment: .top) {
                    
                    Color.black.opacity(viewModel.backgroundOpacity)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture { viewModel.hide() }
                    
                    
                    VStack {
                        
                        //Color.clear
                        //    .ignoresSafeArea()
                        //    .safeAreaPadding(.all)
                        //    .frame(height: geometry.safeAreaInsets.top)

                        content()
                            .padding(.top, geometry.safeAreaInsets.top)
                            .padding(.bottom, geometry.safeAreaInsets.bottom)
                            .padding(.horizontal, self.viewModel.horizontalPadding)
                            .background(self.viewModel.backgroundColor)
                            .cornerRadius(15, corners: [.allCorners])
                            .shadow(radius: 10)
                            .offset(y: self.viewModel.sheetOffset + dragOffset)
                            .gesture(
                                DragGesture()
                                    .updating($dragOffset) { value, state, _ in
                                        if value.translation.height < 0 {
                                            self.viewModel.sheetOffset = value.translation.height
                                        }
                                    }
                                    .onEnded { value in
                                        if value.translation.height < 0 {
                                            viewModel.hide()
                                        }
                                    }
                            )
                    }
                    .transition(.move(edge: .top))

                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
}




// Custom modifier to round only bottom corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    
    func fillTopSafeArea<Content: View>(color: Color, @ViewBuilder content: @escaping() -> Content) -> some View {
        GeometryReader { geometry in
            ZStack{
                Color.clear
                VStack{
                    let _ = print("geometry.safeAreaInsets.top == > \(geometry.safeAreaInsets.top)")
                    Color.black
                        .ignoresSafeArea()
                        .safeAreaPadding(.all)
                        .frame(height: geometry.safeAreaInsets.top)
                    VStack(spacing: 0) {
                        color.frame(height: geometry.safeAreaInsets.top)
                        content()
                        //Color.green.frame(height: 300)
                        Spacer()
                    }
                }
            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    

}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


