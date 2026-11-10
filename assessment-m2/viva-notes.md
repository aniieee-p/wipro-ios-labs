# Viva notes: GCD and Swift concurrency

## Grand Central Dispatch (GCD)

GCD schedules blocks of work on dispatch queues. Use a global queue for suitable background work and the main queue for UI operations. `DispatchQueue.main.async` schedules a closure to run later on the main queue; it does not wait for the closure's result.

## async/await

An `async` function can suspend without blocking its thread. `await` marks a point where the caller waits asynchronously for that function's result. Declaring an async function does not start it; it must be called from an asynchronous context.

## Task

`Task { ... }` creates and starts an asynchronous unit of work from a synchronous context such as a button action. Retaining its handle allows the caller to request cancellation. Cancellation is cooperative: the operation must check for it or call cancellation-aware APIs.

## Task groups

A task group starts related child tasks concurrently and gathers their results. Its children are structured: the group does not leave scope until all children finish or are cancelled. Use a group when independent operations can run together and their combined results are needed.

## In this demo

The task-list screen follows MVVM: the view sends user actions to a view model, which owns presentation-facing state and delegates task rules to a model. The dashboard starts two independent fetches in a throwing task group. The dashboard view model stores a `Task` handle to support cancellation and changes its state on the main actor.
