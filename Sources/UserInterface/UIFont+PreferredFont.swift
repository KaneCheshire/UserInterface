import UIKit

public extension UIFont {

    static func preferredFont(for style: UIFont.TextStyle, with weight: UIFont.Weight = .regular) -> UIFont {
        let description = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: description.pointSize, weight: weight)
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
}

