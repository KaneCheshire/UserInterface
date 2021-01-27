import UIKit

public extension Array where Element == NSLayoutConstraint {

	func activate() { NSLayoutConstraint.activate(self) }
}

extension UILayoutPriority: ExpressibleByIntegerLiteral {

	public init(integerLiteral value: Int) {
		self = .init(Float(value))
	}
}

public extension UIView {

	func pin(
		to view: UIView,
		insets: NSDirectionalEdgeInsets = .zero,
		edges: NSDirectionalRectEdge = .all,
		safeAreaEdges: NSDirectionalRectEdge = [],
		bottomPriority: UILayoutPriority = .required
	) {
		translatesAutoresizingMaskIntoConstraints = false
		var constraints: [NSLayoutConstraint] = []
		if edges.contains(.top) {
			constraints.append(topAnchor.constraint(equalTo: view.topAnchor(safeArea: safeAreaEdges.contains(.top)), constant: insets.top))
		}
		if edges.contains(.leading) {
			constraints.append(leadingAnchor.constraint(equalTo: view.leadingAnchor(safeArea: safeAreaEdges.contains(.leading)), constant: insets.leading))
		}
		if edges.contains(.bottom) {
			constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor(safeArea: safeAreaEdges.contains(.bottom)), constant: insets.bottom).with(priority: bottomPriority))
		}
		if edges.contains(.trailing) {
			constraints.append(trailingAnchor.constraint(equalTo: view.trailingAnchor(safeArea: safeAreaEdges.contains(.trailing)), constant: insets.trailing))
		}
		constraints.activate()
	}

	func pin(
		subview: UIView,
		insets: NSDirectionalEdgeInsets = .zero,
		edges: NSDirectionalRectEdge = .all,
		safeAreaEdges: NSDirectionalRectEdge = [],
		bottomPriority: UILayoutPriority = .required
	) {
		addSubview(subview)
		subview.translatesAutoresizingMaskIntoConstraints = false
		var constraints: [NSLayoutConstraint] = []
		if edges.contains(.top) {
			constraints.append(subview.topAnchor.constraint(equalTo: topAnchor(safeArea: safeAreaEdges.contains(.top)), constant: insets.top))
		}
		if edges.contains(.leading) {
			constraints.append(subview.leadingAnchor.constraint(equalTo: leadingAnchor(safeArea: safeAreaEdges.contains(.leading)), constant: insets.leading))
		}
		if edges.contains(.bottom) {
			constraints.append(subview.bottomAnchor.constraint(equalTo: bottomAnchor(safeArea: safeAreaEdges.contains(.bottom)), constant: insets.bottom).with(priority: bottomPriority))
		}
		if edges.contains(.trailing) {
			constraints.append(subview.trailingAnchor.constraint(equalTo: trailingAnchor(safeArea: safeAreaEdges.contains(.trailing)), constant: insets.trailing))
		}
		constraints.activate()
	}

	func pin(
		subview: UIView,
		insets: CGFloat,
		edges: NSDirectionalRectEdge = .all,
		safeAreaEdges: NSDirectionalRectEdge = [],
		bottomPriority: UILayoutPriority = .required
	) {
		let insets = NSDirectionalEdgeInsets(top: insets, leading: insets, bottom: -insets, trailing: -insets)
		pin(subview: subview, insets: insets, edges: edges, safeAreaEdges: safeAreaEdges, bottomPriority: bottomPriority)
	}

	func center(
		subview: UIView,
		insets: CGFloat = 0
	) {
		subview.translatesAutoresizingMaskIntoConstraints = false
		addSubview(subview)
		NSLayoutConstraint.activate([
			subview.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: insets),
			subview.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: insets),
			subview.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: insets),
			subview.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor, constant: insets),
			subview.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -insets),
			subview.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -insets)
		])
	}

	func constrainWidth(toAtLeast min: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		widthAnchor.constraint(greaterThanOrEqualToConstant: min).isActive = true
	}

	func constrainHeight(toAtLeast min: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(greaterThanOrEqualToConstant: min).isActive = true
	}
}

public extension UIView {

	func topAnchor(safeArea: Bool) -> NSLayoutYAxisAnchor {
		safeArea ? safeAreaLayoutGuide.topAnchor : topAnchor
	}

	func bottomAnchor(safeArea: Bool) -> NSLayoutYAxisAnchor {
		safeArea ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor
	}

	func leadingAnchor(safeArea: Bool) -> NSLayoutXAxisAnchor {
		safeArea ? safeAreaLayoutGuide.leadingAnchor : leadingAnchor
	}

	func trailingAnchor(safeArea: Bool) -> NSLayoutXAxisAnchor {
		safeArea ? safeAreaLayoutGuide.trailingAnchor : trailingAnchor
	}
}

public extension NSLayoutConstraint {

	func with(priority: UILayoutPriority) -> NSLayoutConstraint {
		self.priority = priority
		return self
	}
}
