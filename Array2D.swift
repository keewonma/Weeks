//
//  Array2D.swift
//  Weeks
//
//  Created by Jonathan Ma on 4/23/16.
//  Copyright © 2016 Jonathan Ma. All rights reserved.
//  
//  Creates a 2D Array of with Int columns and Int rows 

import Foundation

struct Array2D<T> {
    let columns: Int
    let rows: Int
    private var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(count: rows*columns, repeatedValue: nil)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row*columns + column]
        }
        set {
            array[row*columns + column] = newValue
        }
    }
}