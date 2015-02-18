//
//  AddRecipeVC.swift
//  HopTimer
//
//  Created by Jason Wiles on 2/17/15.
//  Copyright (c) 2015 TallB Studios. All rights reserved.
//

import UIKit
import CoreData


protocol RecipeAddDelegate{
    
    func didAddRecipe(recipeAdded: Recipe?)
    func addRecipeCanceled()
}


class AddRecipeVC: UIViewController {

    @IBOutlet var txtRecipeName: UITextField!
    @IBOutlet var txtBoilTime: UITextField!
    @IBOutlet var txtStyle: UITextField!
    
    //cancel button press
    @IBAction func Cancel(sender: AnyObject) {
        
    }
    
    
    @IBAction func Save(sender: AnyObject) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtRecipeName.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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




/*
//FROM OLD HOP TIMER
//
//  AddRecipeViewController.swift
//  HopTimer
//
//  Created by Jason Wiles on 7/14/14.
//  Copyright (c) 2014 TallB Studios. All rights reserved.
//



class AddRecipeViewController: UIViewController {


var managedObjectContext: NSManagedObjectContext? = nil

var detailItem: Recipe? {
didSet {

}
}

var delegate: RecipeAddDelegate?



@IBAction func cancel(sender: AnyObject) {
//dismiss and remove the object
//self.detailItem!.managedObjectContext.deleteObject(self.detailItem)
self.delegate?.addRecipeCanceled()
}


@IBAction func save(sender: AnyObject) {
//User wants to add a recipe
//Insert a new object into the context


//Check to make sure they actually entered a recipe name
if txtRecipeName!.text.isEmpty {
//No recipe name was entered so let them know about it via a AlertController
var alert: UIAlertController = UIAlertController(title: "No Recipe Name", message: "Please enter a recipe name", preferredStyle: UIAlertControllerStyle.Alert)
var cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
alert.addAction(cancelAction)
self.presentViewController(alert, animated: true, completion: nil)

}
else{
//Create a new recipe object for the entity
var recipe = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: self.managedObjectContext!) as Recipe
//Set it's name and boil time
recipe.name = txtRecipeName!.text
if !txtBoilTime!.text.isEmpty {
recipe.boilTime = txtBoilTime!.text.toInt()!
}

//Save the context
var err: NSError? = nil
if !self.managedObjectContext!.save(&err){
NSLog(err!.description)
}

//tell the delegate that a new recipe was entered
self.delegate?.didAddRecipe(recipe)
}

}



}
*/