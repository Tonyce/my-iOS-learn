//
//  AddInfoViewController.swift
//  myLogin
//
//  Created by D_ttang on 15/6/22.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class AddInfoViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    var diary = CellEntry?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        saveBtn.setTitle(GoogleIcon.e649, forState: UIControlState.Normal)
        closeBtn.setTitle(GoogleIcon.e811, forState: UIControlState.Normal)
        content.text = ""
        content.becomeFirstResponder()
        let date = Date()
        timeLabel.text = date.stringWithFormat()
//        content.backgroundColor = UIColor.whiteColor()
        content.layer.borderColor = UIColor.orangeColor().CGColor

        contentView.layer.cornerRadius = 3
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowRadius = 5.0
        contentView.layer.shadowColor = UIColor.blackColor().CGColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let contentValue = content.text ?? ""
        let date = Date()
        let time = String(date.getTime().hour) + "." + String(date.getTime().minute)
        // Set the meal to be passed to MealListTableViewController after the unwind segue.
        diary = CellEntry(time: time, content: contentValue)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
