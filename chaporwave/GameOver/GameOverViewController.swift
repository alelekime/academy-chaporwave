//
//  GameOverViewController.swift
//  chaporwave
//
//  Created by Alessandra Souza da Silva on 09/02/22.
//

import UIKit

class GameOverViewController: UIViewController {

    
    @IBOutlet weak var scoreLabel: UILabel!
    var gameVC: GameViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = GameManager.score.description
        
    }
    
    @IBAction func newGame(_ sender: Any) {
        gameVC.reset()
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func menu(_ sender: Any) {
        navigationController?.popToRootViewController(animated: false)
        
    
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
