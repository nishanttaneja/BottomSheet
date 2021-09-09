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
    
    // MARK: Properties
    
    weak var delegate: BottomSheetViewDelegate?
    
    // Gestures
    private var tapGesture: UITapGestureRecognizer!
    

    // MARK: Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
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
