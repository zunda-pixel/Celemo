//
//  CircleSlider.swift
//  Celemo
//
//  Created by zunda on 2021/10/21.
//

import SwiftUI


struct CircleSlider: View {
    @Binding private var bindingValue: Double
    
    @State private var angle: Double = 0
    
    private let width: CGFloat
    private let height: CGFloat
    
    private let beginAngle: Double
    private let endAngle: Double
    
    private let minimumValue: Double
    private let maximumValue: Double
    
    private var value: Double {
        let percent: Double = (self.angle - self.beginAngle) / (self.endAngle - self.beginAngle)
        
        var value: Double = (self.maximumValue - self.minimumValue) * percent + self.minimumValue
        
        if value < self.minimumValue {
            value = self.minimumValue
        }
        
        if self.maximumValue < value {
            value = self.maximumValue
        }
        
        return value
    }
    
    private func calculateAngle(from value: Double) -> Double {
        let percent: Double = (value - self.minimumValue) / (self.maximumValue - self.minimumValue)
                
        let angle: Double = percent * (self.endAngle - self.beginAngle) + self.beginAngle
                
        return angle
    }
    
    public init(_ binding: Binding<Double>,
                width: CGFloat = 250, height: CGFloat = 250,
                beginAngle: Double = 0.0, endAngle: Double = 1.0,
                minimumValue: Double = 0, maximumValue: Double = 100) {
        self._bindingValue = binding
        
        self.width = width
        self.height = height
        
        self.beginAngle = beginAngle
        self.endAngle = endAngle
        
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
    }
    
    private func onChanged(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        // 中央からタップ位置までの距離
        let distanceX: Double = self.width  / 2 - vector.dx
        let distanceY: Double = self.height / 2 - vector.dy
        
        // Circle()の中央からタップ位置のラジアンアークタンジェント2を求める
        let radians: Double = atan2(distanceX, distanceY)
        
        let center: Double = (self.endAngle + self.beginAngle) / 2.0
        
        let angle: Double = center - (radians / (2.0 * .pi))
        
        // アニメーションをつけているが、つけなくてももちろん問題ない
        withAnimation(Animation.linear(duration: 0.1)){
            self.angle = self.endAngle < angle ? self.endAngle : angle
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: self.beginAngle, to: self.endAngle)
                .stroke(Color.black.opacity(0.2), lineWidth: 20)
                .frame(width: self.width, height: self.height)
                .rotationEffect(.init(degrees: 90))
                .gesture(
                    DragGesture().onChanged(self.onChanged(value:))
                )
            Circle()
                .trim(from: self.beginAngle, to: self.angle)
                .stroke(Color.orange, lineWidth: 20)
                .frame(width: self.width, height: self.height)
                .rotationEffect(.init(degrees: 90))
                .gesture(
                    DragGesture().onChanged(self.onChanged(value:))
                )
        }
        .onChange(of: self.value) { value in
            self.bindingValue = value
        }
        .onAppear {
            self.angle = self.calculateAngle(from: self.bindingValue)
        }
    }
}
