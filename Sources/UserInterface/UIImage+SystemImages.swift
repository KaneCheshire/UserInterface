//
//  UIImage+SystemImages.swift
//  
//
//  Created by Kane Cheshire on 21/10/2020.
//

import UIKit

public extension UIImage {

	static let infoCircleFill = UIImage(systemName: "info.circle.fill")!
	static let ellipsisCircleFill = UIImage(systemName: "ellipsis.circle.fill")!
	static let plusCircleFill = UIImage(systemName: "plus.circle.fill")!
	static let boltFill = UIImage(systemName: "bolt.fill")!
	static let mapFill = UIImage(systemName: "map.fill")!
	static let gearshapeFill = UIImage(systemName: "gearshape.fill")!
	static let squareAndArrowUp = UIImage(systemName: "square.and.arrow.up")!
	static let xmarkBin = UIImage(systemName: "xmark.bin")
}

public extension UIImage {

	func with(pointSize: CGFloat) -> UIImage { applyingSymbolConfiguration(.init(pointSize: 26))! }
	func with(weight: UIImage.SymbolWeight) -> UIImage { applyingSymbolConfiguration(.init(weight: weight))! }
}
