//
//  BottomSheetViewController.swift
//  BottomSheetViewController
//
//  Created by Mind on 10/09/21.
//

import UIKit

class BottomSheetViewController: UIViewController, BottomSheetViewDelegate {
    
    // MARK: Subviews
    
    private let bottomSheetView: BottomSheetView
    
    
    // MARK: Constructors
    
    init() {
        bottomSheetView = BottomSheetView()
        super.init(nibName: nil, bundle: nil)
        bottomSheetView.delegate = self
        self.view = bottomSheetView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bottomSheetView.presentBottomSheet()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bottomSheetView.dismissBottomSheet()
    }
    
    
    // MARK: BottomSheetViewDelegate
    
    func bottomSheetViewDidSelect(view: BottomSheetView) {
        dismiss(animated: true)
    }
    
}
