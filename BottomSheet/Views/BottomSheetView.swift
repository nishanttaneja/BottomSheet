//
//  BottomSheetView.swift
//  BottomSheetView
//
//  Created by Mind on 10/09/21.
//

import UIKit

@objc protocol BottomSheetViewDelegate: NSObjectProtocol {
    @objc optional func bottomSheetViewDidSelect(view: BottomSheetView)
}

class BottomSheetView: UIView {
    
    // MARK: Subviews
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentStackView)
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = kBottomSheetTitle
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .black
        return label
    }()
    
    private(set) lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = kPlaceholderText
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, textLabel, .init()])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = itemSpacing
        return stack
    }()
    
    
    // MARK: Properties
    
    weak var delegate: BottomSheetViewDelegate?
    
    // Gesture
    private var panGesture: UIPanGestureRecognizer!
    
    // Height
    private let defaultHeight: CGFloat = 300
    private var currentHeight: CGFloat = 300
    private let maximumHeight: CGFloat = UIScreen.main.bounds.height - 64
    private let dismissibleHeight: CGFloat = 200
    
    private let titleLabelHeight: CGFloat = 44
    
    private let padding: CGFloat = 16
    private let itemSpacing: CGFloat = 8
    
    
    // MARK: Constraints
    
    // ContentView
    private var contentViewHeightConstraint: NSLayoutConstraint?
    private var contentViewBottomConstraint: NSLayoutConstraint?
    private lazy var contentViewConstraints: [NSLayoutConstraint] = {
        contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: defaultHeight)
        contentViewBottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: defaultHeight)
        return [
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentViewBottomConstraint!,
            contentViewHeightConstraint!
        ]
    }()
    
    func presentBottomSheet() {
        contentViewBottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    
    func dismissBottomSheet() {
        contentViewBottomConstraint?.constant = defaultHeight
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    
    // TitleLabel
    private lazy var contentStackConstraints: [NSLayoutConstraint] = {[
        contentStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
        contentStackView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: padding),
        contentStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
        contentStackView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -padding)
    ]}()
    

    // MARK: Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black.withAlphaComponent(0.8)
        addSubview(contentView)
        NSLayoutConstraint.activate(contentViewConstraints + contentStackConstraints)
        configGesture()
    }
    
    private func configGesture() {
        panGesture = .init(target: self, action: #selector(handleViewPanGesture(recognizer:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Selectors
    
    @objc private func handleViewTapGesture(recognizer: UITapGestureRecognizer) {
        delegate?.bottomSheetViewDidSelect?(view: self)
    }
    
    @objc private func handleViewPanGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        let isDraggingDown = translation.y > 0
        let newHeight = currentHeight - translation.y

        switch recognizer.state {
        case .changed:
            if newHeight < maximumHeight {
                contentViewHeightConstraint?.constant = newHeight
                layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                dismissBottomSheet()
                delegate?.bottomSheetViewDidSelect?(view: self)
            } else if newHeight < defaultHeight {
                updateHeightWithAnimation(to: defaultHeight)
            } else if newHeight < maximumHeight, isDraggingDown {
                updateHeightWithAnimation(to: defaultHeight)
            } else if newHeight > defaultHeight, !isDraggingDown {
                updateHeightWithAnimation(to: maximumHeight)
            }
        default: break
        }
    }
    
    private func updateHeightWithAnimation(to newHeight: CGFloat) {
        contentViewHeightConstraint?.constant = newHeight
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        } completion: { _ in
            self.currentHeight = newHeight
        }
    }
    
}
