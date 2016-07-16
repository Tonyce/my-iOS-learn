//
//  SelfSetViewController.swift
//  myLogin
//
//  Created by D_ttang on 15/6/27.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SelfSetViewController: UIViewController {
    
    @IBOutlet weak var selfImage: UIImageView!
    @IBOutlet weak var selfWord: UITextView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
//        let meImage = UIView(frame:CGRectMake(100, 135, 70, 70))

//        meImage.backgroundColor = UIColor.brownColor()
        selfImage.layer.cornerRadius = 35
//        meImage.layer.shadowOpacity = 0.75
//        meImage.layer.shadowRadius = 5.0
//        meImage.layer.shadowColor = UIColor.blackColor().CGColor
//        meImage.layer.shadowOffset = CGSize(width: 0, height: 1.5)
//        view.addSubview(meImage)
//        meImage.userInteractionEnabled = true
//        meImage.addGestureRecognizer(UIGestureRecognizer(target: self, action: Selector("tapImage:")))
        

        // Do any additional setup after loading the view.
    }
    
    func tapImage(recognizer: UITapGestureRecognizer){
        print("taped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissThisView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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

extension SelfSetViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("setCell")! as UITableViewCell
        cell.textLabel?.text = "setCell"
        return cell
    }
}

extension SelfSetViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func selectImageFromLib(sender: AnyObject) {
        let imagePickController = UIImagePickerController()
        imagePickController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePickController.delegate = self
        presentViewController(imagePickController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        selfImage.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
