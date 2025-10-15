{-# LANGUAGE OverloadedStrings #-}

module Database.Students
  ( insertStudent
  , updateStudent
  ) where

import Database.SQLite.Simple

insertStudent :: Connection -> String -> String -> String -> IO ()
insertStudent conn name group email = do
    _ <- execute conn
        "INSERT INTO students (student_name, \"group\", email) VALUES (?, ?, ?)"
        (name, group, email)
    putStrLn "Student inserted"

updateStudent :: Connection -> Int -> String -> String -> String -> IO ()
updateStudent conn sid name group email = do
    _ <- execute conn
        "UPDATE students SET student_name = ?, \"group\" = ?, email = ? WHERE id = ?"
        (name, group, email, sid)
    putStrLn "Student updated"
