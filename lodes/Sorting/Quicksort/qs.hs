quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = let smaller = quicksort $ filter (< x) xs
                       larger = quicksort $ filter (>= x) xs
                   in smaller ++ [x] ++ larger
