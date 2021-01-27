import UIKit

open class Circle: UIView {

	public init() {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalTo: widthAnchor).isActive = true
	}

	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override open func layoutSubviews() {
		super.layoutSubviews()
		cornerRadius = frame.width / 2
	}
}

open class Oblong: UIView {

	public enum Axis {
		case vertical, horizontal
	}

	private let axis: Axis

	public init(_ axis: Axis = .horizontal) {
		self.axis = axis
		super.init(frame: .zero)
	}

	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override open func layoutSubviews() {
		super.layoutSubviews()
		switch axis {
		case .horizontal: cornerRadius = frame.height / 2
		case .vertical: cornerRadius = frame.width / 2
		}
	}
}
