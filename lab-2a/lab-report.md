\# Lab 2A: Functions and Higher-Order Functions



\## R1: Reusable Functions



Implemented four reusable functions:



\- `calculateMean(of:)` calculates the average of numbers.

\- `findMaximum(in:)` finds the largest number.

\- `isValidEmail(\_:)` checks an email-like input.

\- `formatDisplayName(\_:)` trims whitespace and formats a person's name.



Each function uses clear parameter labels and an explicit return type.



\## R2: Higher-Order Functions



Used:

\- `filter` to select expense transactions.

\- `map` to extract transaction amounts.

\- `reduce` to calculate total expenses.



The total expenses are ₹4,100. Also implemented the optional extension to calculate spending by category.



\## R3: Sorting Students



Used `sorted` to arrange students by marks in descending order. When two students have equal marks, their names are sorted alphabetically.



\## R4: Loop-Based vs Higher-Order Functions



The loop-based approach uses an explicit variable, a `for` loop, and an `if` condition to calculate expenses. The higher-order approach combines `filter`, `map`, and `reduce`.



Both approaches produce the same total. Loops can be easier to understand for beginners and complex step-by-step logic, while higher-order functions make data transformations more concise and expressive.



\## R5: Parameter Labels and Return Types



Used descriptive parameter labels such as `of:` and `in:`, along with explicit return types. Optional return values are used when a mean or maximum cannot be calculated from an empty array.



\## Test Results



The source code includes test cases for mean calculation, maximum value, valid and invalid email inputs, and display-name formatting. It also prints a small test table showing expected and actual results.



\## Conclusion



This lab demonstrates reusable Swift functions, higher-order functions, sorting, parameter labels, return types, and the differences between loop-based and functional programming approaches.

