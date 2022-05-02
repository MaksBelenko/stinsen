//
//  File.swift
//  
//
//  Created by Maksim on 02/05/2022.
//
import UIKit.UIVisualEffectView
import SwiftUI

struct VisualEffectBlurView: UIViewRepresentable {
    
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}
