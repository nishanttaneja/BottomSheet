//
//  BottomSheetViewController.swift
//  BottomSheetViewController
//
//  Created by Mind on 10/09/21.
//

import UIKit

protocol BottomSheetViewControllerDelegate: NSObjectProtocol {
    func bottomSheetViewControllerWillAppear(withDuration animationDuration: CGFloat)
    func bottomSheetViewControllerWillDisappear(withDuration animationDuration: CGFloat)
}

class BottomSheetViewController: UIViewController, BottomSheetViewDelegate, BottomSheetViewDataSource {
        
    // MARK: - Subviews
    
    private let bottomSheetView: BottomSheetView
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = kBottomSheetTitle
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .black
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = kPlaceholderText
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    
    // MARK: - Delegation
    
    weak var delegate: BottomSheetViewControllerDelegate? = nil
    
    
    // MARK: - BottomSheetView
    
    // MARK: DataSource
    
    func viewToDisplayAsBottomSheetView() -> UIView {
        let stack = UIStackView(arrangedSubviews: [titleLabel, textLabel, .init()])
        stack.axis = .vertical
        return stack
        
    }
    
    // MARK: Delegate
    
    func bottomSheetViewDidSelect(view: BottomSheetView) {
        dismiss(animated: true)
    }
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.bottomSheetViewControllerWillAppear(withDuration: bottomSheetView.animationDuration)
        bottomSheetView.presentBottomSheet()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.bottomSheetViewControllerWillDisappear(withDuration: bottomSheetView.animationDuration)
        bottomSheetView.dismissBottomSheet()
    }
    
    
    // MARK: - Configuration
    
    private func config() {
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSheetView)
        NSLayoutConstraint.activate([
            bottomSheetView.topAnchor.constraint(equalTo: view.topAnchor),
            bottomSheetView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomSheetView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    init() {
        bottomSheetView = BottomSheetView()
        super.init(nibName: nil, bundle: nil)
        bottomSheetView.delegate = self
        bottomSheetView.dataSource = self
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
