{-# LANGUAGE OverloadedStrings #-}

module SQL.TablesInit
  ( initDB
  ) where

import Database.SQLite.Simple
import Database.ConnectDB

initDB :: IO ()
initDB = do
    conn <- connectDB

    -- Students
    execute_ conn $
      "CREATE TABLE IF NOT EXISTS students (\
      \id INTEGER PRIMARY KEY AUTOINCREMENT, \
      \student_name TEXT NOT NULL, \
      \`group` TEXT NOT NULL, \
      \email TEXT UNIQUE)"

    -- Teachers
    execute_ conn $
      "CREATE TABLE IF NOT EXISTS teachers (\
      \id INTEGER PRIMARY KEY AUTOINCREMENT, \
      \teacher_name TEXT NOT NULL, \
      \department TEXT, \
      \email TEXT UNIQUE)"

    -- Software Packages
    execute_ conn $
      "CREATE TABLE IF NOT EXISTS software_packages (\
      \id INTEGER PRIMARY KEY AUTOINCREMENT, \
      \title TEXT NOT NULL, \
      \description TEXT, \
      \version TEXT, \
      \author_id INTEGER NOT NULL, \
      \author_type TEXT NOT NULL CHECK(author_type IN ('student','teacher')))"

    -- Seminars
    execute_ conn $
      "CREATE TABLE IF NOT EXISTS seminars (\
      \id INTEGER PRIMARY KEY AUTOINCREMENT, \
      \topic TEXT NOT NULL, \
      \date TEXT, \
      \audience INTEGER)"

    -- Demonstrations
    execute_ conn $
      "CREATE TABLE IF NOT EXISTS demonstrations (\
      \id INTEGER PRIMARY KEY AUTOINCREMENT, \
      \package_id INTEGER NOT NULL, \
      \date TEXT, \
      \audience INTEGER, \
      \FOREIGN KEY(package_id) REFERENCES software_packages(id) \
      \ON DELETE CASCADE ON UPDATE CASCADE)"

    -- Tests
    execute_ conn $
      "CREATE TABLE IF NOT EXISTS tests (\
      \id INTEGER PRIMARY KEY AUTOINCREMENT, \
      \package_id INTEGER NOT NULL, \
      \test_date TEXT, \
      \result INTEGER, \
      \FOREIGN KEY(package_id) REFERENCES software_packages(id) \
      \ON DELETE CASCADE ON UPDATE CASCADE)"

    -- Student-Teacher relation
    execute_ conn $
      "CREATE TABLE IF NOT EXISTS student_teacher_relation (\
      \student_id INTEGER NOT NULL, \
      \teacher_id INTEGER NOT NULL, \
      \PRIMARY KEY(student_id, teacher_id), \
      \FOREIGN KEY(student_id) REFERENCES students(id) \
      \ON DELETE CASCADE ON UPDATE CASCADE, \
      \FOREIGN KEY(teacher_id) REFERENCES teachers(id) \
      \ON DELETE CASCADE ON UPDATE CASCADE)"

    putStrLn "SQLite tables created successfully"
    close conn