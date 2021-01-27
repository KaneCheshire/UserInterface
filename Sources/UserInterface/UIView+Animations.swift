import UIKit
import FoundationExtension

public extension UIView {

	func crossfade(
		duration: TimeInterval,
		animations: @escaping Block
	) {
		UIView.transition(
			with: self,
			duration: duration,
			options: [.allowAnimatedContent, .beginFromCurrentState],
			animations: animations,
			completion: nil)
	}
}
