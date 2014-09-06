//
//  DatabaseManager.swift
//  Project1
//
//  Created by Ryan Soscia on 9/6/14.
//  Copyright (c) 2014 MHacks. All rights reserved.
//

import Foundation

class DatabaseManager {
    
    var dataList: [String] = " "
    var numberOfRows: Int = 0
    var databaseName: String = " "
    var tableName: String = " "
    var db_open_status: Bool
    var table_ok: Bool
    var my_columns_names: [AnyObject]?              // what's the differnce between the "?" and the "!"

    if self.openDBwithSQLName(databaseName) {
    
        db_open_status = true
    
        if(!self.createTable(tableName, WithColumns:my_columns_names) {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Warning:" message:@"The table did has NOT been created" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [av show];
        }else{
            table_ok = YES;
        }
    }
    
    override func viewDidLoad()
    {
    super.viewDidLoad();
    dataList = [[NSMutableArray alloc]init];
    numberOfRows = 0;
    databaseName = @"mysampledatabase";
    tableName = @"mypeople";
    db_open_status = NO;
    table_ok = NO;
    my_columns_names = [[NSArray alloc]initWithObjects:@"name", @"age", nil];
    
    if([self openDBWithSQLName:databaseName]) {
        db_open_status = YES;
        if(![self createTable:tableName WithColumns:my_columns_names]) {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Warning:" message:@"The table did has NOT been created" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [av show];
        }else{
            table_ok = YES;
        }
    }
    }
        
    
}