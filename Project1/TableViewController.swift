
import UIKit

class TableViewController: UITableViewController {
    @IBAction func back(sender: AnyObject) {
        self.performSegueWithIdentifier("BackSegue", sender: self)
    }
}