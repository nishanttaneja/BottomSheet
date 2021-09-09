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
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    // MARK: Properties
    
    weak var delegate: BottomSheetViewDelegate?
    
    // Gestures
    private var tapGesture: UITapGestureRecognizer!
    
    // Height
    private let defaultHeight: CGFloat = 300
    
    
    // MARK: Constraints
    
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
    

    // MARK: Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black.withAlphaComponent(0.8)
        addSubview(contentView)
        NSLayoutConstraint.activate(contentViewConstraints)
        configGesture()
    }
    
    private func configGesture() {
        tapGesture = .init(target: self, action: #selector(handleViewTapGesture(recognizer:)))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Selectors
    
    @objc private func handleViewTapGesture(recognizer: UITapGestureRecognizer) {
        delegate?.bottomSheetViewDidSelect?(view: self)
    }
    
}
