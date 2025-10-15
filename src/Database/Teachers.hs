{-# LANGUAGE OverloadedStrings #-}

module Database.Teachers
  ( insertTeacher
  , updateTeacher
  ) where

import Database.SQLite.Simple

insertTeacher :: Connection -> String -> String -> String -> IO ()
insertTeacher conn name department email = do
    _ <- execute conn
        "INSERT INTO teachers (teacher_name, department, email) VALUES (?, ?, ?)"
        (name, department, email)
    putStrLn "Teacher inserted"

updateTeacher :: Connection -> Int -> String -> String -> String -> IO ()
updateTeacher conn tid name department email = do
    _ <- execute conn
        "UPDATE teachers SET teacher_name = ?, department = ?, email = ? WHERE id = ?"
        (name, department, email, tid)
    putStrLn "Teacher updated"
