//
//  PreferencesViewController.swift
//  GameSource
//
import UIKit
import Firebase

class PreferencesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func exitPref(_ sender: Any) {
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
        
        /* TODO */
        // Change the value of the preference in the database
        // We changed the value of sender in pressSwitch so keep
        // that in mind
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        pressSwitch(sender)
        
        /* TODO */
        // Change the value of the preference in the database
        // We changed the value of sender in pressSwitch so keep
        // that in mind
    }
    
    @IBAction func switchRPG(_ sender: UISwitch) {
        pressSwitch(sender)
        
        /* TODO */
        // Change the value of the preference in the database
        // We changed the value of sender in pressSwitch so keep
        // that in mind
    }
    
    @IBAction func switchSports(_ sender: UISwitch) {
        pressSwitch(sender)
        
        /* TODO */
        // Change the value of the preference in the database
        // We changed the value of sender in pressSwitch so keep
        // that in mind
    }
    
    @IBAction func switchHorror(_ sender: UISwitch) {
        pressSwitch(sender)
        
        /* TODO */
        // Change the value of the preference in the database
        // We changed the value of sender in pressSwitch so keep
        // that in mind
    }
    
    @IBAction func switchCasual(_ sender: UISwitch) {
        pressSwitch(sender)
        
        /* TODO */
        // Change the value of the preference in the database
        // We changed the value of sender in pressSwitch so keep
        // that in mind
    }
    
    @IBAction func switchStrategy(_ sender: UISwitch) {
        pressSwitch(sender)
        
        /* TODO */
        // Change the value of the preference in the database
        // We changed the value of sender in pressSwitch so keep
        // that in mind
    }
    
    @IBAction func switchMMO(_ sender: UISwitch) {pressSwitch(sender)
        
        /* TODO */
        // Change the value of the preference in the database
        // We changed the value of sender in pressSwitch so keep
        // that in mind
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
