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
    var cardInitialCenter:CGPoint!
    var currentRotation:CGFloat!
    
    var firstLaunch=false
    let gameRef=Database.database().reference(withPath: "games")
    let imagesRef=Storage.storage().reference()
    var curr:GSGame!
    var potentials=[GSGame]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if(firstLaunch){
            let screenRect=UIScreen.main.bounds
            let coverView=UIView(frame:screenRect)
            coverView.backgroundColor=UIColor.black.withAlphaComponent(0.6)
            self.view.addSubview(coverView)
            let guideView=UILabel(frame:screenRect)
            guideView.text="Swipe left to upvote the game; \n \n \n swipe right to let it go"
            guideView.adjustsFontSizeToFitWidth=true
            guideView.textAlignment=NSTextAlignment.center
            guideView.font=UIFont(name: "HelveticaNeue-UltraLight", size: 35)
            guideView.textColor=UIColor.white
            guideView.numberOfLines=0
            coverView.addSubview(guideView)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
                coverView.removeFromSuperview()
            }
        }
        gameRef.observe(.value, with: {snapshot in
            if(snapshot.exists()){
                print("Great")
            }else{print("humm")}
            var newGames: [GSGame] = []
            
            for child in snapshot.children{
                if let snapshot1 = child as? DataSnapshot,
                    let game = GSGame(snapshot:snapshot1){
                    print("ok")
                    newGames.append(game)
                }
            }
                print("?")
                self.curr=newGames[0]
            newGames.remove(at: 0)
            if(newGames.count>0){
                for i in newGames{
                    var contained=false;
                    for j in self.potentials{
                        if(i.gameid==j.gameid){
                            contained=true;
                            break;
                        }
                    }
                    if(!contained){
                        self.potentials.append(i)
                    }
                }
            }
            self.updateData()
        })


        //let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        //swipeLeft.direction = .left
        //self.view.addGestureRecognizer(swipeLeft)
        
        //let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        //swipeRight.direction = .right
        //self.view.addGestureRecognizer(swipeRight)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            cardInitialCenter=posterImageView.center
            currentRotation=0
        } else if sender.state == .changed {
            posterImageView.center=CGPoint(x: cardInitialCenter.x+translation.x, y: cardInitialCenter.y+translation.y)
            if(location.y<cardInitialCenter.y){
                if(translation.x>0){
                    currentRotation=currentRotation.advanced(by: 0.02)
                    posterImageView.transform=view.transform.rotated(by: currentRotation)
                }
                else{
                    currentRotation=currentRotation.advanced(by: -0.02)
                    posterImageView.transform=view.transform.rotated(by: currentRotation)
                }
            }
            else{
                if(translation.x<0){
                    currentRotation=currentRotation.advanced(by: 0.02)
                    posterImageView.transform=view.transform.rotated(by: currentRotation)
                }
                else{
                    currentRotation=currentRotation.advanced(by: -0.02)
                    posterImageView.transform=view.transform.rotated(by: currentRotation)
                }
                
            }
        } else if sender.state == .ended {
            if(translation.x>50){
                print("Swipe Right")
                DatabaseManager.rateGame(user: GSUser(user:Auth.auth().currentUser!), game: curr, vote: false)
                curr=potentials[0]
                potentials.remove(at: 0)
                updateData()
            }
            else if(translation.x<(-50)){
                print("Swipe Left")
                DatabaseManager.rateGame(user: GSUser(user:Auth.auth().currentUser!), game: curr, vote: true)
                curr=potentials[0]
                potentials.remove(at: 0)
                updateData()
            }
                posterImageView.center=cardInitialCenter
                posterImageView.transform=CGAffineTransform.identity
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didLog(_ sender: Any) {
        performSegue(withIdentifier: "logoutSegue", sender: self)
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
    
    /*@objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {

        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            
        }
    }*/
    
    func updateData() -> Void{
        if(curr.picRefString==""){
            self.posterImageView.image=#imageLiteral(resourceName: "icons8-game-controller-50")
        }else{
       let imageRef=imagesRef.child(curr.picRefString)
        imageRef.getData(maxSize: 10*1024*1024, completion: {
            data,error in
            if let error=error{
                print(error.localizedDescription)
            }else {
                self.posterImageView.image=UIImage(data:data!)
            }
        })}
        descLabel.text=curr.gameintro
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
