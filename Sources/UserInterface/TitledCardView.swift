import UIKit
import FoundationExtension

open class TitledCardView: CardView {

	public init(title: String, _ content: UIView..., infoButtonHandler: Block? = nil) {
        let titleLabel = UILabel()
            .with(\.font, .preferredFont(for: .title1))
            .with(\.numberOfLines, 1)
		let firstView: UIView
		if let handler = infoButtonHandler {
			firstView = UIStackView([
				titleLabel,
				IconButton(UIImage.infoCircleFill.with(pointSize: .idealIconButtonSize), handler)
			], axis: .horizontal, distribution: .fillProportionally)
		} else {
			firstView = titleLabel
		}
		super.init(
			firstView,
			UIStackView(content)
		)
	}

	required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
