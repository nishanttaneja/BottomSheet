//
//  HomeViewController.swift
//  BottomSheet
//
//  Created by Mind on 10/09/21.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate {
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = kHomeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        updateView()
    }
    
    private func updateView() {
        let homeView = HomeView(frame: view.frame)
        homeView.delegate = self
        view = homeView
    }
    
    
    // MARK: HomeViewDelegate
    
    func homeView(_ view: HomeView, didSelect button: UIButton) {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalTransitionStyle = .crossDissolve
        bottomSheetVC.modalPresentationStyle = .overCurrentContext
        present(bottomSheetVC, animated: true)
    }

}
