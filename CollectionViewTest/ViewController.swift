//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Yura on 28.07.2023.
//


// info https://stackoverflow.com/questions/25895311/uicollectionview-self-sizing-cells-with-auto-layout

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colView: UICollectionView!
    
    var arr = ["fnef", "qdknwk",  "feknwknw", "fnfn", "ee", "ghruhrurhgu",  "qbq", "wqbqqbqnwbnw", "qbq", "nenje" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colView.dataSource = self
        colView.delegate = self
        
        if let flowLayout = colView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let text = arr[indexPath.row]
//        let font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body) //UIFont.systemFont(ofSize: 17.0)
//        let size = text.size(
//            withAttributes:[.font: font])
//
//        let  width = size.width + 28
//        return CGSize(width: CGFloat(width), height: 60);
//    }
}
