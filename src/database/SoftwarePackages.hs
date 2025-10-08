insertSoftwarePackage :: Connection -> String -> String -> String -> Int -> String -> IO ()
insertSoftwarePackage conn title desc version authorId authorType = do
    _ <- execute conn
        "INSERT INTO software_packages (title, description, version, author_id, author_type) VALUES (?, ?, ?, ?, ?)"
        (title, desc, version, authorId, authorType)
    putStrLn "Software package inserted"

updateSoftwarePackage :: Connection -> Int -> String -> String -> String -> Int -> String -> IO ()
updateSoftwarePackage conn pid title desc version authorId authorType = do
    _ <- execute conn
        "UPDATE software_packages SET title = ?, description = ?, version = ?, author_id = ?, author_type = ? WHERE id = ?"
        (title, desc, version, authorId, authorType, pid)
    putStrLn "Software package updated"
