//
//  BrowseViewController.swift
//  GameSource
//
//  Created by Ruben A Gonzalez on 4/16/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import Firebase

class BrowseViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var curr: GSGame!
    override func viewDidLoad() {
        super.viewDidLoad()
        //curr=DatabaseManager.getGame()
        updateData()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapPicture(_ sender: Any) {
        performSegue(withIdentifier: "detailsSegue", sender: sender)
    }
    @IBAction func didTapPost(_ sender: Any) {
        performSegue(withIdentifier: "postSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="detailsSegue"{
            let desti=segue.destination as! DetailsViewController
            desti.curr=self.curr
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
            //DatabaseManager.likeGame(curr)
            //curr=DatabaseManager.getGame()
            updateData()
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
            //DatabaseManager.passGame(curr)
            //curr=DatabaseManager.getGame()
            updateData()
        }
    }
    
    func updateData() -> Void{
        //posterImageView.image=
        //
        //
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
