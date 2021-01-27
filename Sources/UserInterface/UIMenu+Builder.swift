//
//  File.swift
//  
//
//  Created by Kane Cheshire on 21/10/2020.
//

import UIKit
import FoundationExtension

public extension UIMenu {

	final class Builder {

		typealias Action = (title: String, icon: UIImage?, attributes: UIAction.Attributes, handler: Block)

		let title: String
		var actions: [Action] = []
		public init(title: String) {
			self.title = title
		}

		public func addAction(_ title: String, icon: UIImage? = nil, attributes: UIAction.Attributes = [], handler: @escaping Block) -> Self {
			actions.append((
				title,
				icon,
				attributes,
				handler
			))
			return self
		}

		public func buildMenu() -> UIMenu {
			UIMenu(title: title, children: actions.map { action in
				UIAction(title: action.title, image: action.icon, attributes: action.attributes, handler: { _ in action.handler() })
			})
		}
		public func buildSheet() -> UIAlertController {
			let sheet = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
			actions.forEach { action in
				let style: UIAlertAction.Style = action.attributes.contains(.destructive) ? .destructive : .default
				sheet.addAction(UIAlertAction(title: action.title, style: style, handler: { _ in
					action.handler()
				}))
			}
			sheet.addAction(.init(title: "Cancel", style: .cancel))
			return sheet
		}
	}
}
