# DataUsage

This application supports universal devices.(iPad and iPhone)

Used cocoapods for saving the data offline - Realm is the framework i have used.
Please install cocoa pods incase if you encounter any issue

Code Coverage Report:


#Helpers
DUDataManger - Saves the data into the realm DB
DUNetworkManager - Fetches the data through a service call using URLSession
DUNetworkErrors - Handles all network failure and success scenarios.

#Models:
DataCycle
Year

#Views:

ViewController - Home screen, where data comsumption is displayed for an year. Year in which data consumption is decreased for
                  quarter is highlighted and tap action will take to DUPopover formsheet
                  
DUPopover - Popover formsheet with data consumption for each quarter in a year

#DataUsageUITests

Need to change workspace settings of xcode inorder to support validating UITests.
Xcode-> Filee -> WorkSpaceSetttings -> Legacy build settings.
