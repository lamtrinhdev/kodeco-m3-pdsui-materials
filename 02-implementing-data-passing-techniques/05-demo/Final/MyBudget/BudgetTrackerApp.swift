/// Copyright (c) 2024 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

// MARK: - Environment Values

struct ExpenseTextColorKey: EnvironmentKey {
  static let defaultValue: Color = .red
}

struct IncomeTextColorKey: EnvironmentKey {
  static let defaultValue: Color = .green
}

extension EnvironmentValues {
  var expenseTextColor: Color {
    get { self[ExpenseTextColorKey.self] }
    set { self[ExpenseTextColorKey.self] = newValue }
  }

  var incomeTextColor: Color {
    get { self[IncomeTextColorKey.self] }
    set { self[IncomeTextColorKey.self] = newValue }
  }
}

// MARK: - Model

struct FinancialEntry: Identifiable {
  let id: UUID
  let amount: Double
  let category: String
  let isExpense: Bool
}

// MARK: - App & View Hierarchy

@main
struct BudgetTrackerApp: App {
  let entries = [
    FinancialEntry(
      id: UUID(),
      amount: 3000,
      category: "Income",
      isExpense: false
    ),
    FinancialEntry(
      id: UUID(),
      amount: 120,
      category: "Groceries",
      isExpense: true
    ),
    FinancialEntry(
      id: UUID(),
      amount: 500,
      category: "Technology",
      isExpense: true
    ),
    FinancialEntry(
      id: UUID(),
      amount: 10,
      category: "Subscription",
      isExpense: true
    )
  ]

  var body: some Scene {
    WindowGroup {
      ContentView(entries: entries)
    }
  }
}

struct ContentView: View {
  let entries: [FinancialEntry]

  var body: some View {
    NavigationView {
      List {
        Section(header: Text("Entries")) {
          ForEach(entries) { entry in
            FinancialEntryRow(entry: entry)
              .environment(\.expenseTextColor, .orange)
          }
        }
      }
      .navigationTitle("Budget Tracker")
    }
  }
}

struct FinancialEntryRow: View {
  let entry: FinancialEntry

  @Environment(\.expenseTextColor)
  var expenseTextColor: Color
  @Environment(\.incomeTextColor)
  var incomeTextColor: Color

  var body: some View {
    HStack {
      Text(entry.isExpense ? "Expense" : "Income")
      Spacer()
      Text("$\(entry.amount, specifier: "%.2f")")
        .foregroundColor(entry.isExpense ?
          expenseTextColor : incomeTextColor)
    }
  }
}
