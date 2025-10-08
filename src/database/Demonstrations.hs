insertDemo :: Connection -> Int -> Day -> Int -> IO ()
insertDemo conn packageId date audience = do
    _ <- execute conn
        "INSERT INTO demonstrations (package_id, date, audience) VALUES (?, ?, ?)"
        (packageId, date, audience)
    putStrLn "Demonstration inserted"

updateDemo :: Connection -> Int -> Int -> Day -> Int -> IO ()
updateDemo conn did packageId date audience = do
    _ <- execute conn
        "UPDATE demonstrations SET package_id = ?, date = ?, audience = ? WHERE id = ?"
        (packageId, date, audience, did)
    putStrLn "Demonstration updated"
