//
//  BottomSheetViewController.swift
//  BottomSheetViewController
//
//  Created by Mind on 10/09/21.
//

import UIKit

class BottomSheetViewController: UIViewController, BottomSheetViewDelegate {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView() {
        let bottomSheetView = BottomSheetView(frame: view.frame)
        bottomSheetView.delegate = self
        view = bottomSheetView
    }
    
    
    // MARK: BottomSheetViewDelegate
    
    func bottomSheetViewDidSelect(view: BottomSheetView) {
        dismiss(animated: true)
    }
    
}
