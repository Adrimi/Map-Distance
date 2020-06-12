//
//  TestableExtensions.swift
//  Map DistanceTests
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import Foundation
import ViewInspector
@testable import Map_Distance

extension Inspection: InspectionEmissary where V: Inspectable {}

extension ContentView: Inspectable {}
extension MapView: Inspectable {}
extension BasicTextField: Inspectable {}
extension BasicTextfieldLabel: Inspectable {}
