insertSeminar :: Connection -> String -> Day -> Int -> IO ()
insertSeminar conn topic date audience = do
    _ <- execute conn
        "INSERT INTO seminars (topic, date, audience) VALUES (?, ?, ?)"
        (topic, date, audience)
    putStrLn "Seminar inserted"

updateSeminar :: Connection -> Int -> String -> Day -> Int -> IO ()
updateSeminar conn sid topic date audience = do
    _ <- execute conn
        "UPDATE seminars SET topic = ?, date = ?, audience = ? WHERE id = ?"
        (topic, date, audience, sid)
    putStrLn "Seminar updated"