//
//  Maths.swift
//  svang-tvos
//
//  Created by Simon Andersson on 19/01/16.
//  Copyright © 2016 svang. All rights reserved.
//

import Foundation
import CoreGraphics

var PI: Float = Float(M_PI)
var PI_2: Float = Float(M_PI_2)
var PI_4: Float = Float(M_PI_4)

extension CGFloat {
	static func random() -> CGFloat {
		return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
	}

	public static func random(min min: CGFloat, max: CGFloat) -> CGFloat {
		return CGFloat.random() * (max - min) + min
	}

	public func radians() -> CGFloat {
		let b = CGFloat(M_PI) * (self/180)
		return b
	}
}

extension Double {
	static func random() -> Double {
		return Double(Float(arc4random()) / 0xFFFFFFFF)
	}

	public static func random(min min: Double, max: Double) -> Double {
		return Double.random() * (max - min) + min
	}
}

public extension Int {
	public static func random (lower lower: Int , upper: Int) -> Int {
		return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
	}
}

func lerp(a: CGFloat, b: CGFloat, t: CGFloat) -> CGFloat {
	return a + (b - a) * t;
}

func lerp(a: Double, b: Double, t: Double) -> Double {
	return a + (b - a) * t;
}

func lerp(a: Float, b: Float, t: Float) -> Float {
	return a + (b - a) * t;
}

func lerp(a: Int, b: Int, t: Int) -> Int {
	return a + (b - a) * t;
}

// MARK: - map

func map(x: CGFloat, in_min: CGFloat, in_max: CGFloat, out_min: CGFloat, out_max: CGFloat) -> CGFloat {
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

func map(x: Double, in_min: Double, in_max: Double, out_min: Double, out_max: Double) -> Double {
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

func map(x: Float, in_min: Float, in_max: Float, out_min: Float, out_max: Float) -> Float {
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

// MARK: - clamp

func clamp(x: CGFloat, minimum: CGFloat, maximum: CGFloat) -> CGFloat {
	return max(minimum, min(maximum, x))
}

func clamp(x: Double, minimum: Double, maximum: Double) -> Double {
	return max(minimum, min(maximum, x))
}

func clamp(x: Float, minimum: Float, maximum: Float) -> Float {
	return max(minimum, min(maximum, x))
}

func clamp(x: Int, minimum: Int, maximum: Int) -> Int {
	return max(minimum, min(maximum, x))
}

// MARK: - angle
func pointFromAngle(angle:CGFloat, distance:CGFloat, origin:CGPoint) -> CGPoint{
    let x = (cos(angle) * distance) + (origin.x)
    let y = (sin(angle) * distance) + (origin.y)
    return CGPoint(x: x, y: y)
}

// MARK: - distance
func distanceBetweenPoints(p1:CGPoint, p2:CGPoint) -> CGFloat {
    let dx = p1.x-p2.x
    let dy = p1.y-p2.y
    return sqrt((dx * dx) + (dy * dy))
}
