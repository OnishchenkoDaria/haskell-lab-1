insertTest :: Connection -> Int -> Day -> Int -> IO ()
insertTest conn packageId testDate result = do
    _ <- execute conn
        "INSERT INTO tests (package_id, test_date, result) VALUES (?, ?, ?)"
        (packageId, testDate, result)
    putStrLn "Test inserted"

updateTest :: Connection -> Int -> Int -> Day -> Int -> IO ()
updateTest conn tid packageId testDate result = do
    _ <- execute conn
        "UPDATE tests SET package_id = ?, test_date = ?, result = ? WHERE id = ?"
        (packageId, testDate, result, tid)
    putStrLn "Test updated"
