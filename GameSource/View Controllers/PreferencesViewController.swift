//
//  PreferencesViewController.swift
//  GameSource
//
import UIKit
import Firebase

class PreferencesViewController: UIViewController {
    let id=Auth.auth().currentUser?.uid
    let prefRef=Database.database().reference().child("preferences")
    var prefDic=["adventure":"n","action":"n","rpg":"n","sports":"n","horror":"n","casual":"n","strategy":"n","educational":"n"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func exitPref(_ sender: Any) {
        //Here is when we update the user's preference modules.
        let userPrefRef=prefRef.child(id!)
        userPrefRef.updateChildValues(prefDic)
        performSegue(withIdentifier: "prefSegue", sender: nil)
    }
    
    func pressSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            sender.setOn(false, animated: true)
            
        } else {
            sender.setOn(true, animated: true)
        }
    }
    
    @IBAction func switchAdventure(_ sender: UISwitch) {
        pressSwitch(sender)
        prefDic["adventure"]="y"
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        pressSwitch(sender)
        prefDic["action"]="y"
    }
    
    @IBAction func switchRPG(_ sender: UISwitch) {
        pressSwitch(sender)
        prefDic["rpg"]="y"
    }
    
    @IBAction func switchSports(_ sender: UISwitch) {
        pressSwitch(sender)
        prefDic["sports"]="y"
    }
    
    @IBAction func switchHorror(_ sender: UISwitch) {
        pressSwitch(sender)
        prefDic["horror"]="y"
    }
    
    @IBAction func switchCasual(_ sender: UISwitch) {
        pressSwitch(sender)
        prefDic["casual"]="y"
    }
    
    @IBAction func switchStrategy(_ sender: UISwitch) {
        pressSwitch(sender)
        prefDic["strategy"]="y"
    }
    
    @IBAction func switchEducational(_ sender: UISwitch) {pressSwitch(sender)
        pressSwitch(sender)
        prefDic["educational"]="y"
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
