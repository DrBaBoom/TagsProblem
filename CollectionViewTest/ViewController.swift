//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Yura on 28.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colView: UICollectionView!
    
    var arr = ["fnef", "qdknwk",  "feknwknw", "fnfn", "ee", "ghruhrurhgu", "qbq", "wqbqqbqnwbnw", "nenje" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colView.dataSource = self
        colView.delegate = self
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCell
        cell.lbl.text = arr[indexPath.row]
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = arr[indexPath.row]
        let size = text.size(
            withAttributes:[.font: UIFont.systemFont(ofSize: 17.0)])
        
        let  randomWidth = size.width + 30
        return CGSize(width: CGFloat(randomWidth ), height: 60);
    }
}
