import UIKit

open class ScrollableStack: UIScrollView {

	private let stack: UIStackView

	public init(
		_ content: UIView...,
		axis: NSLayoutConstraint.Axis = .vertical,
		spacing: CGFloat = .paddingSmall,
		padding: CGFloat = .paddingDefault
	) {
		self.stack = UIStackView(content, axis: axis, spacing: spacing)
		super.init(frame: .zero)
		pin(subview: stack, insets: padding)
		if axis == .vertical {
			contentLayoutGuide.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		} else {
			contentLayoutGuide.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
		}
		contentInsetAdjustmentBehavior = .always
	}

	required public init?(coder: NSCoder) {
		fatalError()
	}
}
