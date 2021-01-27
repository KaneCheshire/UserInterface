import UIKit
import FoundationExtension

open  class EmptyStateView: UIView {

	private var onTap: Block
	private let titleLabel: UILabel
	private let button = UIButton(type: .system)
	private lazy var stack = UIStackView([titleLabel, button], spacing: .paddingSmall)

	public init(title: String, buttonTitle: String, onTap: @escaping Block) {
		self.onTap = onTap
		titleLabel = UILabel()
            .with(\.font, as: .preferredFont(for: .title1))
            .with(\.textAlignment, as: .center)
		super.init(frame: .zero)
		pin(subview: stack, insets: .paddingSmall)
		button.setTitle(buttonTitle, for: .normal)
		button.addTarget(self, action: #selector(buttonTap), for: .primaryActionTriggered)
	}

	required public init?(coder: NSCoder) {
		fatalError()
	}

	@objc private func buttonTap() { onTap() }
}
