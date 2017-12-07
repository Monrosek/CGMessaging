//
//  BubbleView.swift
//  CGMessaging
//
//  Created by Mac on 12/6/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

@IBDesignable class BubbleView: UIView {

    @IBInspectable public var HeightOfTriangle:CGFloat = 20.0 {
        didSet {
            guard HeightOfTriangle > 10 else {
                HeightOfTriangle = 10
                return
            }
        }
    }
    
    @IBInspectable public var WidthOfTriangle:CGFloat = 40.0 {
        didSet {
            guard WidthOfTriangle > 20 else {
                WidthOfTriangle = 20
                return
            }
        }
    }
    
    @IBInspectable public var BorderRadius:CGFloat = 3.0
    @IBInspectable public var StrokeWidth:CGFloat = 10.0
    @IBInspectable public var StrokeColor:UIColor = .blue
    @IBInspectable public var FillColor:UIColor = .green
    @IBInspectable public var MagicNumber:CGFloat = 0.5
   
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0.0, y: self.bounds.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        let currentFrame = self.bounds
        context?.setLineJoin(.round)
        context?.setLineWidth(StrokeWidth)
        context?.setStrokeColor(StrokeColor.cgColor)
        context?.setFillColor(FillColor.cgColor)
        
        context?.beginPath()
   
          
        context?.move(to: CGPoint( //13.5,30.5
            x: BorderRadius + StrokeWidth + MagicNumber,
            y: StrokeWidth + HeightOfTriangle + MagicNumber))
        
        context?.addLine(to: CGPoint(//132.5,30.5
            x: BorderRadius + StrokeWidth + MagicNumber,
            y:  StrokeWidth + MagicNumber))
        context?.addLine(to: CGPoint(
            x: BorderRadius + StrokeWidth + MagicNumber + WidthOfTriangle,
            y: HeightOfTriangle + StrokeWidth + MagicNumber))
        context?.addLine(to: CGPoint(
            x: round(currentFrame.size .width / 2 - WidthOfTriangle / 2) + MagicNumber,
            y: HeightOfTriangle + StrokeWidth + MagicNumber))
        
        
        context?.addArc(
            tangent1End: CGPoint(
                x: currentFrame.size.width - StrokeWidth - MagicNumber,
                y: StrokeWidth + HeightOfTriangle + MagicNumber),
            tangent2End: CGPoint(
                x: currentFrame.size.width - StrokeWidth - MagicNumber,
                y: currentFrame.size.height - StrokeWidth - MagicNumber)
            , radius: BorderRadius - StrokeWidth)
        
        context?.addArc(
            tangent1End: CGPoint(
                x: currentFrame.size.width - StrokeWidth - MagicNumber,
                y: currentFrame.size.height - StrokeWidth - MagicNumber),
            tangent2End: CGPoint(
                x: round(currentFrame.size.width / 2 + WidthOfTriangle / 2) - StrokeWidth + MagicNumber,
                y: currentFrame.size.height - StrokeWidth - MagicNumber)
            , radius: BorderRadius - StrokeWidth)
        
        context?.addArc(
            tangent1End: CGPoint(
                x: StrokeWidth + MagicNumber,
                y: currentFrame.size.height - StrokeWidth - MagicNumber),
            tangent2End: CGPoint(
                x: StrokeWidth + MagicNumber,
                y: HeightOfTriangle + StrokeWidth + MagicNumber),
            radius: BorderRadius - StrokeWidth)
        
        context?.addArc(
            tangent1End: CGPoint(
                x: StrokeWidth + MagicNumber,
                y: HeightOfTriangle + StrokeWidth + MagicNumber),
            tangent2End: CGPoint(
                x: currentFrame.size.width - StrokeWidth - MagicNumber,
                y: HeightOfTriangle + StrokeWidth + MagicNumber),
            radius: BorderRadius - StrokeWidth)
        
        
        //Close and Draw
        context?.closePath()
        context?.drawPath(using: .fillStroke)
    }
    
    
   
}

