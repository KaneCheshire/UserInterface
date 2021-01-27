import UIKit
import FoundationExtension

public final class TapGestureRecognizer: UITapGestureRecognizer {

	private let onTapped: Block

	public init(_ onTapped: @escaping Block) {
		self.onTapped = onTapped
		super.init(target: nil, action: nil)
		addTarget(self, action: #selector(onTap))
	}

	@objc private func onTap() {
		onTapped()
	}
}
