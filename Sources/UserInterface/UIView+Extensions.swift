import UIKit
import FoundationExtension

public extension CACornerMask {

	static let trailing: CACornerMask = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
	static let top: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
	static let all: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
}

public extension UIView {

	var cornerRadius: CGFloat {
		get { layer.cornerRadius }
		set { layer.cornerRadius = newValue }
	}

	var maskedCorners: CACornerMask {
		get { layer.maskedCorners }
		set { layer.maskedCorners = newValue }
	}

	var cornerCurve: CALayerCornerCurve {
		get { layer.cornerCurve }
		set { layer.cornerCurve = newValue }
	}

	func addTapGesture(_ block: @escaping Block) {
		addGestureRecognizer(TapGestureRecognizer(block))
		accessibilityTraits.insert(.button)
	}

	@discardableResult
	func addPanGesture(_ block: @escaping Closure<PanGesture.State>) -> PanGesture {
		let pan = PanGesture(block)
		addGestureRecognizer(pan)
		return pan
	}

	func setShadow(
		_ color: UIColor = .black,
		offset: CGVector = .zero,
		radius: CGFloat = 3.0,
		opacity: CGFloat = 0.2
	) {
		layer.shadowColor = color.cgColor
		layer.shadowOffset = CGSize(width: offset.dx, height: offset.dy)
		layer.shadowRadius = radius
		layer.shadowOpacity = Float(opacity)
	}

	func removeShadow() {
		layer.shadowOpacity = 0
	}
}

