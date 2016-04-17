//
//  CGVector+Math.swift
//  svang-tvos
//
//  Created by Simon Andersson on 04/12/15.
//  Copyright © 2015 svang. All rights reserved.
//

import Foundation
import SpriteKit

/**
* Operator + to add two vectors together
*
* - parameter lhs: Left vector object
* - parameter rhs: Right vector object
*
* - returns: the added vector
*/
func + (lhs: CGVector, rhs: CGVector) -> CGVector {
	return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
}

/**
* Operator += to append right vector to left
*
* - parameter lhs: Left vector object
* - parameter rhs: Right vector object
*
* - returns: the added vector
*/
func += (inout lhs: CGVector, rhs: CGVector) -> CGVector {
	lhs = CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
	return lhs
}

/**
* Operator += to append right vector to left
*
* - parameter lhs: Left vector object
* - parameter rhs: Right vector object
*
* - returns: the added vector
*/
func += (inout lhs: CGVector, rhs: CGFloat) -> CGVector {
	lhs = CGVector(dx: lhs.dx + rhs, dy: lhs.dy + rhs)
	return lhs
}

/**
* Operator += to append right vector to left
*
* - parameter lhs: Left vector object
* - parameter rhs: Right vector object
*
* - returns: the added vector
*/
func -= (inout lhs: CGVector, rhs: CGFloat) -> CGVector {
	lhs = CGVector(dx: lhs.dx - rhs, dy: lhs.dy - rhs)
	return lhs
}

/**
* Operator *= to append right vector to left
*
* - parameter lhs: Left vector object
* - parameter rhs: Right CGFloat
*
* - returns: the added vector
*/
func *= (inout lhs: CGVector, rhs: CGFloat) -> CGVector {
	lhs = CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
	return lhs
}

/**
* Operator *= to append right vector to left
*
* - parameter lhs: Left vector object
* - parameter rhs: Right CGFloat
*
* - returns: the added vector
*/
func *= (inout lhs: CGVector, rhs: CGVector) -> CGVector {
	lhs = CGVector(dx: lhs.dx * rhs.dy, dy: lhs.dy * rhs.dy)
	return lhs
}

/**
* Operator * to multipy two vectors together
*
* - parameter lhs: Left vector object
* - parameter rhs: Right vector object
*
* - returns: multiplied vector
*/
func * (lhs: CGVector, rhs: CGVector) -> CGVector {
	return CGVector(dx: lhs.dx * rhs.dx, dy: lhs.dy * rhs.dy)
}

/**
* Operator * to multipy a vectors by a cgfloat factor
*
* - parameter lhs: Left vector object
* - parameter rhs: Right hand float
*
* - returns: multiplied vector by factor
*/
func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
	return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
}

/**
* Operator * to multipy a vectors by a float factor
*
* - parameter lhs: Left vector object
* - parameter rhs: Right hand float
*
* - returns: multiplied vector by factor
*/
func * (lhs: CGVector, rhs: Float) -> CGVector {
	return lhs * CGFloat(rhs)
}

/**
* Operator * to multipy a vectors by a double factor
*
* - parameter lhs: Left vector object
* - parameter rhs: Right hand float
*
* - returns: multiplied vector by factor
*/
func * (lhs: CGVector, rhs: Double) -> CGVector {
	return lhs * CGFloat(rhs)
}

/**
* Operator / to divide two vectors
*
* - parameter lhs: Left vector object
* - parameter rhs: Right vector object
*
* - returns: Divided vector
*/
func / (lhs: CGVector, rhs: CGVector) -> CGVector {
	return CGVector(dx: lhs.dx / rhs.dx, dy: lhs.dy / rhs.dy)
}

/**
*Extension to convert vector to CGPoint
*/
extension CGVector {
	func toPoint() -> CGPoint {
		return CGPoint(x: self.dx, y: self.dy)
	}
}

extension CGPoint {
	func toVector() -> CGVector {
		return CGVector(dx: self.x, dy: self.y)
	}
}

/**
* Operator += to append right point to left
*
* - parameter lhs: Left point object
* - parameter rhs: Right point object
*
* - returns: the added point
*/
func += (inout lhs: CGPoint, rhs: CGPoint) -> CGPoint {
	lhs = CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	return lhs
}

func * (lhs: CGPoint, rhs: CGSize) -> CGPoint {
	return CGPoint(x: lhs.x * rhs.width, y: lhs.y * rhs.height)
}

func *= (inout lhs: CGPoint, rhs: CGSize) -> CGPoint {
	lhs = CGPoint(x: lhs.x * rhs.width, y: lhs.y * rhs.height)
	return lhs
}
