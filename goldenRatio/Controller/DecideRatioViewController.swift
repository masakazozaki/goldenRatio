//
//  DecideRatioViewController.swift
//  goldenRatio
//
//  Created by Masakaz Ozaki on 2019/01/03.
//  Copyright © 2019 Masakazu Ozaki. All rights reserved.
//

import UIKit

class DecideRatioViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let ratioArray = ["goldenRatio", "SilverRatio","asdf", "asdf", "dfgsh"]
    
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ratioArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chooseRatioCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RatioCell", for: indexPath) as! ChooseRatioCell
        chooseRatioCell.cellLabel.text = ratioArray[indexPath.item]
        
        return chooseRatioCell
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
