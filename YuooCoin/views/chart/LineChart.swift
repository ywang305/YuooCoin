//
//  LineChart.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/13/21.
//

import SwiftUI


struct LineChart: View {
    var data: [Double] = [5.5, 4.32, 15.11, 6.9, 9.77, 12.14, 14.13, 11.5]
    var color: Color = .black
    var lineWidth: CGFloat = 2
    
    private var list: [CGPoint] {
        data.enumerated().map{ CGPoint(x: Double($0), y: $1) }
    }
    
    private let lineRadius: CGFloat = 0.5
    
    private var minYValue: CGFloat {
        list.min{ $0.y < $1.y }?.y ?? 0
    }
    private var maxYValue: CGFloat {
        list.max { $0.y < $1.y }?.y ?? 0
    }
    private var rangeYValue: CGFloat {
        maxYValue - minYValue
    }
    private var maxXValue: CGFloat {
        list.max { $0.x < $1.x }?.x ?? 0
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let calcY = { (y: CGFloat) in
                    geometry.size.height - ((y - minYValue) / self.rangeYValue) * geometry.size.height
                }
                
                // 1
                var previousPoint = CGPoint(x: 0, y: calcY(list.first?.y ?? 0))
                
                path.move(to: previousPoint)
                
                self.list.dropFirst().forEach { point in
                    let x = (point.x / self.maxXValue) * geometry.size.width
                    let y = calcY(point.y)
                    
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
                self.color,
                style: StrokeStyle(lineWidth: self.lineWidth)
            )
        }
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart( color: .blue)
    }
}
