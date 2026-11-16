# Course Planner: 2–4 Minute Demo Script

Record a real screen capture of the app running in an iOS Simulator or device on macOS. Target duration: about 3 minutes.

1. **0:00–0:25 — Problem and home.** Introduce the student scheduling problem. Show the empty planner and the planned, available, and 18-credit summary.
2. **0:25–1:00 — Catalog and search.** Open the catalog, search for “design” or an instructor name, and explain that filtering is a collection transformation over the local catalog.
3. **1:00–1:30 — Detail and add.** Open a course detail, point out credits and meeting time, and add it to the plan. Return home and show the updated credit count.
4. **1:30–2:10 — Schedule and removal.** Open the weekly schedule, show weekday/time ordering, and remove a course with the row action. Explain that schedule and home share one view model.
5. **2:10–2:40 — Business rules.** Add Swift Concurrency after Mobile Networking to trigger their Tuesday time-conflict rule. Then add Swift Foundations, iOS Interface Design, Mobile Networking, Testing Workshop, Product Studio, and UX Research Methods; this valid non-overlapping set exceeds the 18-credit limit. Show the user-facing messages. Point out that back-to-back sessions are allowed.
6. **2:40–3:00 — Tests and limits.** Show the passing `swift test` result after running it on macOS, summarize conflict/credit unit tests, and disclose that the catalog is in-memory only.

Do not state that tests pass or quote profiling results unless you have actually run the tests and measurements.
