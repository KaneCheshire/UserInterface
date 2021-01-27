import UIKit

public protocol BottomSheetControllerDelegate: AnyObject {

	func bottomSheet(_ bottomSheet: BottomSheetController, animationsForState state: BottomSheetController.State)
}

public protocol BottomSheetControllerContent: UIViewController {

	var bottomSheetSizing: BottomSheetController.Sizing { get }
	var peekHeight: CGFloat { get }
	var collapsedHorizontalInsets: CGFloat { get }

	func bottomSheetStateDidChange(_ state: BottomSheetController.State)
	func animations(for state: BottomSheetController.State)
}

public extension BottomSheetControllerContent {

	var bottomSheet: BottomSheetController { parent as! BottomSheetController }
	var bottomSheetSizing: BottomSheetController.Sizing { .fullSafeArea }
	var peekHeight: CGFloat { .defaultPeekHeight }
	var collapsedHorizontalInsets: CGFloat { .paddingSmall }
	
	func bottomSheetStateDidChange(_ state: BottomSheetController.State) {}
	func animations(for state: BottomSheetController.State) {}
}

open class BottomSheetController: BaseViewController {

	public enum State {
		case collapsed, expanded, expanding, collapsing
	}

	public enum Sizing {
		case fullSafeArea, auto
	}

	public var state: State = .collapsed {
		didSet {
			switch state {
			case .collapsed:
				animateFromCurrentPosition(isCollapsed: true, allowsUserInteraction: true)
			case .expanding:
				stopAtCurrentPositionAndUpdateAnimation(isCollapsed: false, allowsUserInteraction: false)
			case .expanded:
				animateFromCurrentPosition(isCollapsed: false, allowsUserInteraction: true)
			case .collapsing:
				stopAtCurrentPositionAndUpdateAnimation(isCollapsed: true, allowsUserInteraction: false)
			}
			content.bottomSheetStateDidChange(state)
		}
	}

	public weak var delegate: BottomSheetControllerDelegate?

	private let content: BottomSheetControllerContent
	private lazy var panGesture = content.view.addPanGesture { [weak self] in self?.on(panState: $0) }
    private lazy var container = UIView().with(\.translatesAutoresizingMaskIntoConstraints, as: false)
	private lazy var collapsedHeightConstraint = container.heightAnchor.constraint(equalToConstant: content.peekHeight)
	private lazy var collapsedBottomConstraint = container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -content.collapsedHorizontalInsets / 2)
	private lazy var collapsedWidthConstraint = container.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -content.collapsedHorizontalInsets * 2)
	private lazy var animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1)

	public init(content: BottomSheetControllerContent) {
		self.content = content
		super.init()
	}

	open override func loadView() { view = EventPassthroughHostView() }

	open override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .clear
		container.cornerRadius = .cornerRadiusDefault
		container.cornerCurve = .continuous
		container.clipsToBounds = true
		view.addSubview(container)
		[
			container.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor(safeArea: true)),
			container.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor).with(priority: .defaultHigh),
			container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			container.widthAnchor.constraint(equalTo: view.widthAnchor).with(priority: .defaultHigh),
			collapsedHeightConstraint,
			collapsedWidthConstraint,
			collapsedBottomConstraint
		].activate()
		embed(content) {
			container.addSubview(content.view)
			[
				content.view.topAnchor.constraint(equalTo: container.topAnchor),
				content.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
				content.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
				content.view.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
			].activate()
		}
		animator.isInterruptible = true
		animator.isUserInteractionEnabled = false
		panGesture.delegate = self
		content.view.scrollView?.panGestureRecognizer.require(toFail: panGesture)
	}

	private func on(panState: PanGesture.State) {
		switch panState {
		case let .panning(translation, _):
			onPanning(translation: translation)
		case let .stopped(translation, velocity):
			onStoppedPanning(translation: translation, velocity: velocity)
		}
	}

	private func onPanning(translation: CGPoint) {
		switch state {
		case .collapsed:
			state = .expanding
		case .expanding:
			animator.fractionComplete = -translation.y / view.safeAreaLayoutGuide.layoutFrame.height
		case .expanded:
			state = .collapsing
		case .collapsing:
			animator.fractionComplete = translation.y / view.safeAreaLayoutGuide.layoutFrame.height
		}
	}

	private func onStoppedPanning(translation: CGPoint, velocity: CGPoint) {
		switch state {
		case .expanding:
			let hasEnoughVelocity = velocity.y < -500
			let hasDraggedEnough = translation.y < -content.peekHeight
			if hasEnoughVelocity || hasDraggedEnough {
				state = .expanded
			} else {
				state = .collapsed
			}
		case .collapsing:
			let hasEnoughVelocity = velocity.y > 500
			let hasDraggedEnough = translation.y > content.peekHeight * 2
			if hasEnoughVelocity || hasDraggedEnough {
				state = .collapsed
			} else {
				state = .expanded
			}
		case .collapsed, .expanded: assertionFailure("Unexpected state \(state)")
		}
	}

	private func animateFromCurrentPosition(isCollapsed: Bool, allowsUserInteraction: Bool) {
		if collapsedHeightConstraint.isActive != isCollapsed {
			stopAtCurrentPositionAndUpdateAnimation(isCollapsed: isCollapsed, allowsUserInteraction: allowsUserInteraction)
		}
		animator.startAnimation()
	}

	private func stopAtCurrentPositionAndUpdateAnimation(isCollapsed: Bool, allowsUserInteraction: Bool) {
		animator.stopAnimation(false)
		if animator.state == .stopped {
			animator.finishAnimation(at: .current)
		}
		animator.isUserInteractionEnabled = allowsUserInteraction
		animator.addAnimations { [weak self] in
			self?.collapsedWidthConstraint.isActive = isCollapsed
			self?.collapsedHeightConstraint.isActive = isCollapsed
			self?.collapsedBottomConstraint.isActive = isCollapsed
			self?.content.animations(for: self!.state)
			self?.delegate?.bottomSheet(self!, animationsForState: self!.state)
			self?.view.layoutIfNeeded()
		}
	}
}

extension BottomSheetController: UIGestureRecognizerDelegate {

	public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		guard let scrollView = content.view.scrollView else { return true }
		switch state {
		case .collapsed, .expanding:
			return true
		case .expanded, .collapsing:
			return scrollView.isAtTop && panGesture.translation.y > 0
		}
	}
}

private extension UIScrollView {

	var isAtTop: Bool { contentOffset.y <= 0 }
}

private extension UIPanGestureRecognizer {

	var translation: CGPoint { translation(in: nil) }
}

private extension UIView {

	var scrollView: UIScrollView? { subviews.first { $0 is UIScrollView } as? UIScrollView }
}
