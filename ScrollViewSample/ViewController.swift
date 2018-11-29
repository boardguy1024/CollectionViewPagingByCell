//
//  ViewController.swift
//  ScrollViewSample
//
//  Created by PIVOT on 2018/11/28.
//  Copyright © 2018年 pivot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    
    let buttonWidth: CGFloat = 90
    let buttonHeight: CGFloat = 70
    let buttonCount: Int = 10
    var isAnimating: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
       createButtons()
    }
    
    private func createButtons() {
        
        for i in 0..<buttonCount {
            let button = UIButton()
            button.frame = CGRect(x: CGFloat(i) * buttonWidth, y: 0, width: buttonWidth, height: buttonHeight)
            button.setTitle("\(i)", for: .normal)
            button.layer.cornerRadius = 35
            button.clipsToBounds = true
            scrollview.addSubview(button)
            button.backgroundColor = .blue
        }
        scrollview.contentSize = CGSize(width: CGFloat(buttonCount) * buttonWidth, height: buttonHeight)
        scrollview.delegate = self
        scrollview.clipsToBounds = false
        
       // scrollview.contentOffset.x = self.view.frame.width / 2 + buttonWidth / 2
    }

    
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isAnimating {
          
        }
        self.isAnimating = false
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isAnimating = true
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.scrollview.setContentOffset(scrollView.contentOffset, animated: false)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       isAnimating = true
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollview.contentOffset.x = scrollView.contentOffset.x + 90
        }) { (_) in
        }
    }
}

