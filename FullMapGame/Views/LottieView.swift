//
//  SwiftUIView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 4/12/24.
//

import SwiftUI
import Lottie
import Foundation
#if targetEnvironment(macCatalyst)
import AppKit
#endif


struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    let lottieFile: String
    
    let animationView = LottieAnimationView()
    
    let animationSpeed: CGFloat
    
    func makeUIView(context: Context) -> UIViewType {
        let view = UIView(frame: .zero)
        
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = animationSpeed
        animationView.play()
        
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
}

#Preview {
    LottieView(lottieFile: "globe", animationSpeed: 2)
}
