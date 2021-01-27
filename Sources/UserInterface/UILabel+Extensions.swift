import UIKit

public extension UILabel {

	convenience init(
		_ style: UIFont.TextStyle,
		_ text: String? = nil,
		_ weight: UIFont.Weight = .bold,
		textAlignment: NSTextAlignment = .natural,
		numberOfLines: Int = 0,
		additionalA11yTraits: UIAccessibilityTraits = []
	) {
		self.init()
		self.font = .preferredFont(for: style, with: weight)
		self.text = text
		self.textAlignment = textAlignment
		self.numberOfLines = numberOfLines
		self.adjustsFontForContentSizeCategory = true
		accessibilityTraits.formUnion(additionalA11yTraits)
	}
}

public extension UIFont { // TODO: Move

	static func preferredFont(for style: UIFont.TextStyle, with weight: UIFont.Weight) -> UIFont {
		let description = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
		let font = UIFont.systemFont(ofSize: description.pointSize, weight: weight)
		let metrics = UIFontMetrics(forTextStyle: style)
		return metrics.scaledFont(for: font)
	}
}
