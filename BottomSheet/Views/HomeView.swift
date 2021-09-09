//
//  HomeView.swift
//  HomeView
//
//  Created by Mind on 10/09/21.
//

import UIKit

@objc protocol HomeViewDelegate: NSObjectProtocol {
    @objc optional func homeView(_ view: HomeView, didSelect button: UIButton)
}

final class HomeView: UIView {
    
    // MARK: Subviews
    
    private(set) lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = kPlaceholderText
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 14)
        return textView
    }()
    
    private(set) lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(kHomeButtonTitle, for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(handleTouchDownEvent(for:)), for: .touchDown)
        return button
    }()
    
    
    // MARK: Properties
    
    private let itemSpacing: CGFloat = 8
    
    weak var delegate: HomeViewDelegate?
    
    
    // MARK: Selectors
    
    @objc private func handleTouchDownEvent(for button: UIButton) {
        delegate?.homeView?(self, didSelect: button)
    }
    
    
    // MARK: Constraints
    
    private lazy var textViewConstraints: [NSLayoutConstraint] = {[
        textView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        textView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        textView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
    ]}()
    
    private lazy var buttonConstraints: [NSLayoutConstraint] = {[
        button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: itemSpacing),
        button.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        button.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ]}()
    
    
    // MARK: Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textView)
        addSubview(button)
        NSLayoutConstraint.activate(textViewConstraints + buttonConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
