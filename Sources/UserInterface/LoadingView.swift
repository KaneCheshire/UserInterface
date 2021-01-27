import UIKit
import FoundationExtension

public final class LoadingView: UIView {

	private let activityIndicator = UIActivityIndicatorView(style: .medium)
	private let titleLabel = UILabel()
        .with(\.font, .preferredFont(for: .title1))
        .with(\.textAlignment, .center)
	private let messageLabel = UILabel()
        .with(\.font, .preferredFont(for: .body))
        .with(\.textAlignment, .center)
	private lazy var stack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [activityIndicator, titleLabel, messageLabel])
		stack.alignment = .center
		stack.distribution = .equalCentering
		stack.spacing = .paddingSmall
		return stack
	}()

	public init() {
		super.init(frame: .zero)
		commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}

	public func set(title: String, message: String) {
		titleLabel.text = title
		messageLabel.text = message
	}

	private func commonInit() {
		activityIndicator.startAnimating()
		pin(subview: stack, insets: .paddingSmall)
	}
}
