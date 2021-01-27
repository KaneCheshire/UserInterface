import UIKit
import FoundationExtension

open class Container: UIView, CustomSpaceDefining {

	public let spacingAfter: CGFloat

	public init(
		_ content: UIView...,
		insets: CGFloat = .paddingDefault,
		axis: NSLayoutConstraint.Axis = .vertical,
		alignment: UIStackView.Alignment = .fill,
		spacing: CGFloat = .paddingSmall,
		spacingAfter: CGFloat = UIStackView.spacingUseDefault
	) {
		self.spacingAfter = spacingAfter
		super.init(frame: .zero)
		let stack = UIStackView(content, axis: axis, alignment: alignment, spacing: spacing)
		pin(subview: stack, insets: insets)
		backgroundColor = .clear
	}

	public init(
		_ content: UIView...,
		insets: NSDirectionalEdgeInsets,
		axis: NSLayoutConstraint.Axis = .vertical,
		alignment: UIStackView.Alignment = .fill,
		spacing: CGFloat = .paddingSmall,
		spacingAfter: CGFloat = UIStackView.spacingUseDefault
	) {
		self.spacingAfter = spacingAfter
		super.init(frame: .zero)
		let stack = UIStackView(content, axis: axis, alignment: alignment, spacing: spacing)
		pin(subview: stack, insets: insets)
		backgroundColor = .clear
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

open class CardView: UIView {

	public var isLoading: Bool = false {
		didSet {
			loadingView.isLoading = isLoading
		}
	}

	private lazy var loadingView = SimpleLoadingView()

	public init(_ content: UIView..., insets: CGFloat = .paddingDefault, spacing: CGFloat = .paddingSmall) {
		super.init(frame: .zero)
		pin(subview: UIStackView(content, spacing: spacing), insets: insets)
		cornerRadius = .cornerRadiusDefault
		loadingView.cornerRadius = cornerRadius
		cornerCurve = .continuous
		backgroundColor = .secondarySystemBackground
		pin(subview: loadingView)
	}

	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
