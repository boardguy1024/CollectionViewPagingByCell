//
//  MyCollectionViewController.swift
//  ScrollViewSample
//
//  Created by PIVOT on 2018/11/29.
//  Copyright © 2018年 pivot. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MyCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let buttonWidth: CGFloat = 90
    let buttonHeight: CGFloat = 70
    let numberOfItems: Int = 10
    
    /* Custom scrollView for paging */
    let pagingScrollView = UIScrollView()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPagingScrollView()
        initCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func initPagingScrollView() {
        pagingScrollView.delegate = self
        
        self.pagingScrollView.frame = collectionView.frame
        self.pagingScrollView.isHidden = true
        self.pagingScrollView.isPagingEnabled = true
        self.pagingScrollView.bounds = CGRect(x: 0, y: 0, width: buttonWidth, height: collectionView.frame.height)
        let contentSize = CGFloat(numberOfItems) * buttonWidth
        self.pagingScrollView.contentSize = CGSize(width: contentSize, height: collectionView.frame.height)
        self.view.addSubview(self.pagingScrollView)
        
    }
    
    private func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.addGestureRecognizer(self.pagingScrollView.panGestureRecognizer)
        self.collectionView.panGestureRecognizer.isEnabled = false
        collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 70)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 0
    }

}

extension MyCollectionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.pagingScrollView {
            var contentOffset = scrollView.contentOffset
            
            let contentOffsetX = self.collectionView.contentInset.left + self.view.frame.width / 2 - buttonWidth / 2
            contentOffset.x = contentOffset.x - contentOffsetX
            self.collectionView.contentOffset = contentOffset
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.pagingScrollView {
            
            print("currentIndex: \(scrollView.contentOffset.x / buttonWidth)")
        }
    }
}

extension MyCollectionViewController: UICollectionViewDelegate {
    
}



extension MyCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.myLabel.text = "\(indexPath.row)"
        cell.backgroundColor = .red
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 35
        return cell
    }
}
