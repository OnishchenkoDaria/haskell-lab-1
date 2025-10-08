insertRelation :: Connection -> Int -> Int -> IO ()
insertRelation conn studentId teacherId = do
    _ <- execute conn
        "INSERT INTO student_teacher_relation (student_id, teacher_id) VALUES (?, ?)"
        (studentId, teacherId)
    putStrLn "Relation inserted"
