//
//  DisneyCharacterTableViewController.swift
//  DisneyJSONSerialization
//
//  Created by Esther on 6/14/23.
//

import UIKit

class DisneyCharacterTableViewController: UITableViewController {

    
    // Placeholder Property to retrieve array data that is trapped within the fetchCharacters function on the model controller
    var characters: [DisneyCharacter] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// array assignment is using closure to pass in the data
        NetworkController.fetchCharacters { array in
            /// Unwrap the property - I want it to return the value of the characters array, not Nil.
            guard let array = array else { return }
            /// Grand Central Dispatch responsible for concurrency
            DispatchQueue.main.async {
                /// Reference self when in closure
                self.characters = array
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// Section shows the same number of rows as data available to fill them, in this case, from the placeholder property in this file that is holding the array
        return characters.count
        
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// define cell identifier to be reused
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        /// define specific location within array for each set of data to display in the cell
        let character = characters[indexPath.row]
        /// Default cell style configuration
        cell.textLabel?.text = "Name: \(character.name)"

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // End of class
