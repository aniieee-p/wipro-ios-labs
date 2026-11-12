# Course Explorer component tree

```text
Lab8AApp
└── CourseExplorerScreen
    └── NavigationStack
        └── Group
            ├── CourseEmptyState                 (when courses are empty)
            └── ScrollView
                └── VStack
                    ├── ExplorerHeader           (ZStack)
                    ├── Category section         (VStack)
                    │   └── horizontal ScrollView / HStack
                    │       └── CategoryPill × N
                    └── Featured section         (VStack)
                        └── LazyVGrid
                            └── NavigationLink
                                └── CourseCard
                                    └── StatusBadge
        └── Navigation destination
            └── CourseDetailScreen
                └── ScrollView / VStack
                    ├── artwork (ZStack)
                    ├── title, subtitle, StatusBadge
                    ├── category and duration
                    ├── description
                    └── Start learning button
```

The app's state is represented by immutable `Course` values. Each destination receives the selected course directly through `NavigationLink(value:)`, avoiding global mutable selection state.
