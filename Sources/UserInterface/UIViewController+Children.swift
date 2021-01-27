import UIKit
import FoundationExtension

public extension UIViewController {

	func embed(
		_ child: UIViewController,
		autolayoutBlock: Block
	) {
		addChild(child)
		child.view.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(child.view)
		autolayoutBlock()
		child.didMove(toParent: self)
	}

	func embed(
		_ child: UIViewController
	) {
		addChild(child)
		view.pin(subview: child.view)
		child.didMove(toParent: self)
	}
}
