//
//  LineChart.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/13/21.
//

import SwiftUI

struct Point {
    let x: CGFloat
    let y: CGFloat
}

struct LineChart: View {
    
    var data: [Point]? = [
        .init(x: 1, y: 5),
        .init(x: 2, y: 4),
        .init(x: 3, y: 15),
        .init(x: 4, y: 6),
        .init(x: 5, y: 9),
        .init(x: 6, y: 12),
        .init(x: 7, y: 14),
        .init(x: 8, y: 11)
    ]
    
    var color: Color?
    
    private let lineRadius: CGFloat = 0.5
    
    private var maxYValue: CGFloat {
        data?.max { $0.y < $1.y }?.y ?? 0
    }
    
    private var maxXValue: CGFloat {
        data?.max { $0.x < $1.x }?.x ?? 0
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                path.move(to: .init(x: 0, y: geometry.size.height))
                // 1
                let first = self.data?.first ?? Point(x: 0, y: geometry.size.height)
                let x = (first.x / self.maxXValue) * geometry.size.width
                let y = geometry.size.height - (first.y / self.maxYValue) * geometry.size.height
                var previousPoint = Point(x: x, y: y)
                
                self.data?.dropFirst().forEach { point in
                    let x = (point.x / self.maxXValue) * geometry.size.width
                    let y = geometry.size.height - (point.y / self.maxYValue) * geometry.size.height
                    
                    // 2
                    let deltaX = x - previousPoint.x
                    let curveXOffset = deltaX * self.lineRadius
                    
                    // 3
                    path.addCurve(to: .init(x: x, y: y),
                                  control1: .init(x: previousPoint.x + curveXOffset, y: previousPoint.y),
                                  control2: .init(x: x - curveXOffset, y: y ))
                    
                    previousPoint = .init(x: x, y: y)
                }
            }
            .stroke(
                self.color ?? .black,
                style: StrokeStyle(lineWidth: 2)
            )
        }
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(data: [.init(x: 10, y: 10), .init(x:20, y:15), .init(x:30, y:5)], color: .black)
    }
}
