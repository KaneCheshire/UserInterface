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
