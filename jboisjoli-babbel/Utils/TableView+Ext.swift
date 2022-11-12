//
//  TableView+Ext.swift
//  gestion-anka-ios
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import Foundation
import UIKit

extension UITableView {
    /// This method registers an array of UITableViewCell subclasses types for resusing.
    /// The reuse id would be the same as string version of Class type.
    ///
    /// - Parameter clsArray: Array of UITableViewCell subclasses types
    func register(cells clsArray: [UITableViewCell.Type]) {
        for cls in clsArray {
            register(cellClass: cls)
        }
    }

    /// Templated method to registers UITableViewCell subclass type for resusing
    ///
    /// - Parameter cls: An UICollectionViewCell subclass type for resusing
    func register<T: AnyObject>(cellClass cls: T.Type, reuseIdentifier: String? = nil) {
        let nibName = String(describing: cls)
        let bundle = Bundle(for: cls)
        register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: reuseIdentifier ?? nibName)
    }

    /// Templated method to registers UITableViewCell subclass type for resusing
    ///
    /// - Parameter cls: An UICollectionViewCell subclass type for reusing
    func register<T>(cellClass cls: T.Type) {
        let nibName = String(describing: cls)
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }

    /// Templated method to dequeue reusable cell, based on provided Type
    ///
    /// - Parameters:
    ///   - cls: Class type
    ///   - indexPath: Index path for dequeue
    /// - Returns: A reusable cell subclass of UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(cellClass cls: T.Type, for indexPath: IndexPath) -> T {
        let nibName = String(describing: cls)
        return dequeueReusableCell(withIdentifier: nibName, for: indexPath) as? T ?? T()
    }

    /// Templated method to dequeue reusable cell, based on provided Type
    ///
    /// - Parameters:
    ///   - cls: Class type
    /// - Returns: A reusable cell subclass of UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(cellClass cls: T.Type) -> T {
        let nibName = String(describing: cls)
        return dequeueReusableCell(withIdentifier: nibName) as? T  ?? T()
    }
}
