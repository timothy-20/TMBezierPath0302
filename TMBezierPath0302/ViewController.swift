//
//  ViewController.swift
//  TMBezierPath0302
//
//  Created by 임정운 on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {
    let _shapeView: TMMashView = TMMashView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear: ", self.view.frame)
        
        self._shapeView.frame = CGRect(x: 0.0, y: 0.0, width: (self.view.frame.width * 0.9), height: (self.view.frame.width * 0.9))
        self._shapeView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        self._shapeView.backgroundColor = .white
        
        self.view.addSubview(self._shapeView)
    }
}

class TMMashView: UIView {
    var hop: Double = 0.0
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let path: UIBezierPath = UIBezierPath()
    
    override func draw(_ rect: CGRect) {
        var width = self.frame.width
        self.hop = self.frame.width / 20.0
        
        while width >= 0.0 {
            let path = UIBezierPath()
            
            path.move(to: CGPoint(x: width, y: 0.0))
            path.addLine(to: CGPoint(x: width, y: self.frame.height))
            path.move(to: CGPoint(x: 0.0, y: width))
            path.addLine(to: CGPoint(x: self.frame.width, y: width))
            path.close()
            
            UIColor.black.set()
            
            if width == self.frame.width / 2 {
                UIColor.red.set()
            }
            
            path.lineWidth = 1.0
            path.stroke()
            
            width -= self.hop
        }
        
        self.drawStar()
    }
    
    //MARK: DRAW Variation
    func drawStar() -> Void {
        let startAngle: Double = Double.pi * 1.5
        let endAngle: Double = startAngle + Double.pi * 2
        let center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        let radius = self.hop * 6.0
        
        self.path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        self.shapeLayer.path = self.path.cgPath
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = UIColor.purple.cgColor
        self.shapeLayer.lineWidth = 2.0
        
        self.shapeLayer.strokeStart = 0.0
        self.shapeLayer.strokeEnd = 0.3
        
        self.layer.addSublayer(self.shapeLayer)
        
        print("startAngle: ", startAngle)
        print("endAngle: ", endAngle)
        
        print("needsPath: ", self.shapeLayer.path ?? "nan")
        print("needsPath.bound: ", self.path.bounds)
        print("needsPath.currentPoint: ", self.shapeLayer.path?.currentPoint ?? "nan")
        
        print("needsPath.pathBounding: ", self.shapeLayer.path?.boundingBox ?? "nan")
        print("needsPath.pathBoundingOfPath: ", self.shapeLayer.path?.boundingBoxOfPath ?? "nan")
    }
    
    func drawAnimation() -> Void {
        
    }
    
    func pointDot() -> Void {
        let startPoint = self.shapeLayer.path?.currentPoint ?? CGPoint(x: 0.0, y: 0.0)
        let pointDot = UIView()
        pointDot.frame.size = CGSize(width: 10.0, height: 10.0)
        pointDot.frame.origin = CGPoint(x: (self.path.bounds.origin.x - (pointDot.frame.size.width / 2)),
                                        y: (self.path.bounds.origin.y - (pointDot.frame.size.height / 2)))
        pointDot.layer.cornerRadius = 5.0
        pointDot.backgroundColor = .black
        
        self.addSubview(pointDot)
    }
}

