import UIKit
import FoundationExtension
import Combine

public final class RadioGroup: UIView {

	public var selected: Int? {
		didSet {
			if let old = oldValue {
				rows[old].isSelected = false
			}
			if let new = selected {
				rows[new].isSelected = true
			}
		}
	}
	public var onSelectionChanged: Closure<Int>

	private let rowsStack = Stack(axis: .vertical )
	private var rows: [Row] = [] {
		didSet { rowsStack.setArrangedSubviews(rows) }
	}

	public init(
		_ rowTitles: [String] = [],
		selected: Int? = nil,
		_ onSelectionChanged: @escaping Closure<Int> = { _ in }
	) {
		self.onSelectionChanged = onSelectionChanged
		super.init(frame: .zero)
		setRows(rowTitles, selected: selected)
		pin(subview: rowsStack)
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	public func setRows(_ rowTitles: [String], selected: Int?) {
		self.rows = rowTitles.enumerated().map { title in
			let row = Row(title.element)
			row.isSelected = title.offset == selected
			row.addTapGesture { [weak self] in
				self?.selected = title.offset
				self?.onSelectionChanged(title.offset)
			}
			return row
		}
		self.selected = selected
	}
}

private extension RadioGroup {

	class Row: UIControl {

		override var isSelected: Bool {
			didSet {
				selectionIndicator.isSelected = isSelected
				if isSelected { accessibilityTraits.insert(.selected) }
				else { accessibilityTraits.remove(.selected) }
			}
		}

		override var isHighlighted: Bool {
			didSet {
				UIView.animate(withDuration: 0.23, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) { [weak self] in
					guard let self = self else { return }
					self.alpha = self.isHighlighted ? 0.5 : 1
				}
			}
		}

		private let selectionIndicator = SelectionIndicator()

		init(_ title: String) {
			super.init(frame: .zero)
			let stack = UIStackView([
				UILabel()
                    .with(\.font, .preferredFont(for: .body))
                    .with(\.numberOfLines, 1),
				selectionIndicator
			], axis: .horizontal)
			stack.isUserInteractionEnabled = false
			pin(subview: stack)
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	}
}

private extension RadioGroup.Row {

	private class SelectionIndicator: Circle {

		var isSelected: Bool = false {
			didSet {
				checkmark.isHidden = !isSelected
				backgroundColor = isSelected ? .tertiarySystemBackground : .systemFill
			}
		}

		private let checkmark = UIImageView(image: UIImage(systemName: "checkmark"))

		override init() {
			super.init()
			widthAnchor.constraint(equalToConstant: 24).isActive = true
			backgroundColor = .white
			pin(subview: checkmark, insets: 4)
			checkmark.tintColor = .label
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	}
}
