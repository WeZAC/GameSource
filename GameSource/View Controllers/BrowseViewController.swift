//
//  BrowseViewController.swift
//  GameSource
//
//  Created by Ruben A Gonzalez on 4/16/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import Firebase

class BrowseViewController: UIViewController{
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    let gameRef=Database.database().reference(withPath: "games")
    let imagesRef=Storage.storage().reference()
    var curr:GSGame!
    var potentials:[GSGame]!
    override func viewDidLoad() {
        super.viewDidLoad()
        gameRef.observe(.value, with: {snapshot in
            var newGames: [GSGame] = []
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot,
                    let game = GSGame(snapshot:snapshot){
                    newGames.append(game)
                }
            }
            if(self.curr==nil){
                self.curr=newGames[0]
            }
            self.potentials.append(contentsOf: newGames)
        })
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
            desti.curr=curr
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
            //DatabaseManager.likeGame(curr)
            curr=potentials[0]
            potentials.remove(at: 0)
            updateData()
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
            //DatabaseManager.passGame(curr)
            curr=potentials[0]
            potentials.remove(at: 0)
            updateData()
        }
    }
    
    func updateData() -> Void{
        posterImageView.image=imagesRef.child(curr.bannerRefString)
        descLabel.text=curr.gametext
        nameLabel.text=curr.gamename
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
