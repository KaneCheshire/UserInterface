import UIKit

public protocol CustomSpaceDefining {

	var spacingAfter: CGFloat { get }
}

public extension CustomSpaceDefining where Self: UIView {

	var spacingAfter: CGFloat { UIStackView.spacingUseDefault }
}

public extension UIStackView {

	convenience init(
		_ content: [UIView],
		axis: NSLayoutConstraint.Axis = .vertical,
		distribution: UIStackView.Distribution = .fill,
		alignment: UIStackView.Alignment = .fill,
		spacing: CGFloat = .paddingDefault
	) {
		self.init(arrangedSubviews: content)
		self.axis = axis
		self.distribution = distribution
		self.spacing = spacing
		self.alignment = alignment
		setSpacing()
	}

	convenience init(
		_ content: UIView...,
		axis: NSLayoutConstraint.Axis = .vertical,
		distribution: UIStackView.Distribution = .fill,
		spacing: CGFloat = .paddingDefault
	) {
		self.init(content, axis: axis, distribution: distribution, spacing: spacing)
	}

	func setArrangedSubviews(_ subviews: [UIView]) {
		arrangedSubviews.forEach { $0.removeFromSuperview() }
		subviews.forEach { addArrangedSubview($0) }
		setSpacing()
	}

	func setSpacing() {
		arrangedSubviews.forEach {
			guard let view = $0 as? CustomSpaceDefining else { return }
			setCustomSpacing(view.spacingAfter, after: $0)
		}
	}
}

public typealias Stack = UIStackView
