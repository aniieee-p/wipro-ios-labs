# Lab 1A – Test Cases

## Validation Test Table

| # | Input | Function | Expected Output | Actual Output |
|---|-------|----------|-----------------|---------------|
| 1 | mark = 0 | isValidMark | Valid | Valid |
| 2 | mark = 100 | isValidMark | Valid | Valid |
| 3 | mark = 30 | isValidMark | Valid (but FAIL result) | Valid mark, but FAIL |
| 4 | mark = 105 | isValidMark | Invalid | Invalid |
| 5 | mark = -5 | isValidMark | Invalid | Invalid |
| 6 | attendance = 105.0 | isValidAttendance | Invalid | Invalid |
| 7 | attendance = 0.0 | isValidAttendance | Valid | Valid |
| 8 | attendance = 100.0 | isValidAttendance | Valid | Valid |

## Grade Calculation Test Table

| # | Marks (5 subjects) | Percentage | Expected Grade | Expected Result |
|---|---------------------|------------|----------------|-----------------|
| 1 | 85, 78, 90, 82, 88 | 84.6% | A | PASS |
| 2 | 95, 95, 95, 95, 95 | 95.0% | A+ | PASS |
| 3 | 70, 72, 74, 71, 73 | 72.0% | B | PASS |
| 4 | 30, 25, 28, 32, 29 | 28.8% | F | FAIL |
