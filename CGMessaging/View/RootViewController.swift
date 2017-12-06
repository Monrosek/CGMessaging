//
//  RootViewController.swift
//  CGMessaging
//
//  Created by Mac on 12/2/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
class RootViewController: SlideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {

        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "chat") {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "menu") {
            self.leftViewController = controller
        }
        super.awakeFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
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
