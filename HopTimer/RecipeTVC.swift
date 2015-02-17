//
//  RecipeTVC.swift
//  HopTimer
//
//  Created by Jason Wiles on 2/16/15.
//  Copyright (c) 2015 TallB Studios. All rights reserved.
//

import UIKit
import CoreData

class RecipeTVC: UITableViewController {

    //Variable to hold the managed object context
    var context: NSManagedObjectContext!
    //Variable to hold the fetched results controller
    var fetchedResultsController: NSFetchedResultsController!
    
    //We want to always have available a reference to the current selected recipe
    var currentRecipe: Recipe!
    
    // segue ID when cell is tapped
    var kShowRecipeSegueID = "showRecipe"
    
    // segue ID when "+" button is tapped
    var kAddRecipeSegueID = "addRecipe"
    
    //will be set to true if the user is adding a new recipe
    var isadding: Bool = false
    
    
    //Function to load recipes into the Fetched Results Controller
    func loadRecipesFR() -> NSFetchedResultsController{
        //All fetched results controllers start with a fetch request
        let fetchRequest = NSFetchRequest(entityName: "Recipe")
        
        //All Fetched Results Controllers must have a sort descriptor in their fetch request
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //Create the controller
        let fetchedRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        //perform the fetch printing an error if there is one
        var error: NSError? = nil
        
        if !fetchedRC.performFetch(&error){
            println("Error: \(error?.localizedDescription)")
        }
        
        return fetchedRC
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSomeData()
        
        fetchedResultsController = loadRecipesFR()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections!.count
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Fetched Results Controllers can have sections and you can view that info using the sections property
        //here we will assign this particular section to a NSFetchedResultsSectionInfo class and return the nbr of objects
        let sectionInfo = fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as UITableViewCell
        let recipe = fetchedResultsController.objectAtIndexPath(indexPath) as Recipe
        cell.textLabel?.text = recipe.name
        
        //DEBUG SECTION COMMENT OUT WHEN DONE
        //display recipe and ingredients in the console
        println(recipe.name)
        println("\(recipe.boilTime)")
        println("\(recipe.ingredient.count)")

        //get an array of the ingredients sorted by boil time
        var sd = NSSortDescriptor(key: "boilTime", ascending: false)
        var ingredients = recipe.ingredient.sortedArrayUsingDescriptors([sd]) as [Ingredient]
        
        for i: Int in 0..<ingredients.count{
            println(ingredients[i].desc)
            println("\(ingredients[i].boilTime)")
        }
        
        //END DEBUG SECTION
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - LoadDefaultData
    func loadSomeData(){
        
        let recipeEntity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: context!)
        let recipe = Recipe(entity: recipeEntity!, insertIntoManagedObjectContext: context)
        
        recipe.name = "Big Boy Porter"
        recipe.boilTime = 60
        
        let ingredientEntity = NSEntityDescription.entityForName("Ingredient", inManagedObjectContext: context!)
        let ingr1 = Ingredient(entity: ingredientEntity!, insertIntoManagedObjectContext: context)
        
        ingr1.desc = "Cascade 1oz"
        ingr1.ingredientType = "Hops"
        ingr1.boilTime = 60
        ingr1.recipe = recipe
        
        let ingr2 = Ingredient(entity: ingredientEntity!, insertIntoManagedObjectContext: context)
        ingr2.desc = "Cascade 1oz"
        ingr2.ingredientType = "Hops"
        ingr2.boilTime = 30
        ingr2.recipe = recipe
        
        let ingr3 = Ingredient(entity: ingredientEntity!, insertIntoManagedObjectContext: context)
        ingr3.desc = "Whirlfloc"
        ingr3.ingredientType = "Clarifier"
        ingr3.boilTime = 10
        ingr3.recipe = recipe

        var error: NSError?
        
        if !context.save(&error){
            println("Could not save \(error)")
        }
    }
    
    
    /*
    //=====================================================================
    //--- NSFetchedResultsController implementation
    //--- Use this to tie core data fetched results to a tableViewController
    //======================================================================
    
    //Lazy Instatiation method to create an instance of NSFetchedResultsController
    lazy var fetchedResultsController: NSFetchedResultsController = {
        //Now we create an NSFetchRequest object and attach it to an entity
        let request = NSFetchRequest(entityName: "Recipe")
        let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: self.context)
        request.entity = entity
        
        //Add in a sort descriptor so the data displayed isn't just random
        var sortDesc: NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        var sortDescriptiors = [sortDesc]
        request.sortDescriptors = sortDescriptiors
        
        let fRC = NSFetchedResultsController(fetchRequest: request,
            managedObjectContext: self.context!, sectionNameKeyPath: nil,
            cacheName: nil)
        
        //fRC.delegate = self
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        var err: NSError?
    
        if !fRC.performFetch(&err){
            NSLog(err!.description)
            abort()
        }
        
        return fRC
        
    }()
    */
}