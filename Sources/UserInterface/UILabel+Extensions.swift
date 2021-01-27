import UIKit

public extension UILabel {

	convenience init(
		additionalA11yTraits: UIAccessibilityTraits = []
	) {
		self.init()
		self.adjustsFontForContentSizeCategory = true
		accessibilityTraits.formUnion(additionalA11yTraits)
	}
}
