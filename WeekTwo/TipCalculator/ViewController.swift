//
//  ViewController.swift
//  TipCalculator
//
//  Created by Alex Parella on 10/27/15. Done very quickly. Do not judge.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let header = UILabel()
    let moneyField = UITextField()
    let percentagePicker = UIPickerView()
    let calculateButton = UIButton(type: .System)
    
    // This array of percentages will be used to fill the 
    // pickerView rows. To add more percentage options, 
    // all we would need to do is add more values to this array
    let percentages = [0.05, 0.10, 0.15, 0.20, 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // This gets the center of the current views frame
        // We can use this to center the subviews that we add
        let center = self.view.center.x
        
        // Adding a label at the top of the screen
        // Set the text to be displayed
        header.text = "Tip Calculator"
        header.frame = CGRect(x: 0, y: 40, width: 150, height: 100)
        // Use the center from earlier in order to center the label
        header.center.x = center
        self.view.addSubview(header)
        
        // Initialize the text field that money amount will be entered into
        moneyField.frame = CGRect(x: 0, y: 100, width: 50, height: 20)
        moneyField.center.x = center
        // We customize the text field by setting different properties
        // Check out other properties by viewing the documentation for UITextField!
        moneyField.keyboardType = .DecimalPad
        moneyField.borderStyle = .RoundedRect
        self.view.addSubview(moneyField)
        
        // Initialize picker view
        percentagePicker.center = CGPoint(x: center, y: 250)
        // Set the picker view's delegate and datasource
        // The objects set will need to conform to the appropriate protocol
        // The picker will then use these objects to get information needed to 
        // display the picker
        percentagePicker.dataSource = self
        percentagePicker.delegate = self
        self.view.addSubview(percentagePicker)
        
        // Initialize the calculate button!
        calculateButton.setTitle("Calculate", forState: .Normal)
        calculateButton.frame = CGRect(x: 0, y:350, width: 100, height: 10)
        calculateButton.center.x = center
        // Tell the button what to do when it is clicked
        // The object passed (self, so this view controller) is sent the message (calculate)
        // This will call the calculate function, which we can use to perform the calculation logic!
        calculateButton.addTarget(self, action: "calculate", forControlEvents: .TouchUpInside)
        self.view.addSubview(calculateButton)
    }
    
    func calculate() {
        // Get values from picker view and textfield
        let money = moneyField.text
        let percentage = percentages[percentagePicker.selectedRowInComponent(0)]
        
        // Convert text field value to numbers
        let pieces = money?.componentsSeparatedByString(".")
        let dollars = Int(pieces![0])
        let cents = Int(pieces![1])
        
        let total = dollars! * 100 + cents!
        
        // Perform Calculation
        let withTax = Double(total) + Double(total) * percentage
        let final = withTax / 100.0
        
        // Display result
        // This creates an alert, and provides an action button that the user can use to dismiss the view
        // If we wanted the button to perform an action, we could provide a closure as the handler parameter, instead of nil
        // When it IS nil, it just has the effect of dismissing the alert
        let alert = UIAlertController(title: "Total", message: "Your total is \(String(final))", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    // PickerViewDelegate method -> Tells the picker view what the text should be for the given row
    // We want it to just be the percentage value from the percentages array that corresponds to that row
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(percentages[row])
    }
    
    // PickerViewDataSource -> Views can have multiple components, but we only want one
    // Try changing this to see how the application changes!
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // PickerViewDataSource method -> How many rows will the view have?
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return percentages.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


































