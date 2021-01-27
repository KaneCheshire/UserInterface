import UIKit

/// A view that ignores all touches unless they fall inside one of the subviews (useful for hosting a collapsed bottom sheep)
open class EventPassthroughHostView: UIView {

	open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		guard self.point(inside: point, with: event) else { return nil } // Ignore any touches outside of this view
		for subview in subviews {
			let point = subview.convert(point, from: self)
			guard let view = subview.hitTest(point, with: event) else { continue }
			return view
		}
		return nil
	}
}
