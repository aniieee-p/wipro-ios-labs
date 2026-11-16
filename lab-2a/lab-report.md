# Lab 2A: Functions and Higher-Order Functions

## R1: Reusable Functions

Implemented four reusable functions:

- `calculateMean(of:)` calculates the average of a list of numbers.
- `findMaximum(in:)` finds the largest number in an array.
- `isValidEmail(_:)` checks whether a string looks like a valid email address.
- `formatDisplayName(_:)` trims whitespace and capitalises each word.

Each function uses clear parameter labels and an explicit return type.

## R2: Higher-Order Functions

Used:
- `filter` to select expense transactions.
- `map` to extract transaction amounts.
- `reduce` to calculate total expenses.

Total expenses are ₹4,100. Also implemented the extension to calculate spending by category.

## R3: Sorting Students

Used `sorted` to arrange students by marks descending. When two students have equal marks, their names are sorted alphabetically.

## R4: Loop-Based vs Higher-Order Functions

The loop-based approach uses an explicit variable and a `for` loop. The higher-order approach chains `filter`, `map`, and `reduce`.

Both produce the same total. Loops are easier to follow for beginners; higher-order functions make data transformations shorter and more readable.

## R5: Parameter Labels and Return Types

Used descriptive labels such as `of:` and `in:`. Optional return values indicate when a result cannot be computed (e.g. mean of an empty array).

## Conclusion

This lab demonstrates reusable functions, higher-order functions, sorting, and the trade-offs between loop-based and functional approaches.
