{-# LANGUAGE OverloadedStrings #-}

module TestAllMethods
    ( testTableMethods
    ) where

import Database.SQLite.Simple
import Data.Time.Calendar (fromGregorian)

import Database.ConnectDB
import SQL.TablesInit
import Database.Students
import Database.Teachers
import Database.SoftwarePackages
import Database.StudentTeacherRelate
import Database.Demonstrations
import Database.Seminars
import Database.Tests

testTableMethods :: IO ()
testTableMethods = do
    -- check if tables exist
    connInit <- connectDB
    initDB connInit
    -- close connInit

    conn <- connectDB

    putStrLn "\n1. Testing Students"
    insertStudent conn "Alice Johnson" "14" "alice@example.com"
    updateStudent conn 1 "Alice Johnson" "23" "alice_new@example.com"

    putStrLn "\n2. Testing Teachers"
    insertTeacher conn "Dr. Brown" "Computer Science" "brown@university.com"
    updateTeacher conn 1 "Dr. Brown" "Mathematics" "brown_new@university.com"

    putStrLn "\n3. Testing Software Packages"
    insertSoftwarePackage conn "AI Toolkit" "Machine learning utilities" "1.0.0" 1 "student"
    updateSoftwarePackage conn 1 "AI Toolkit Updated" "New ML utilities" "1.1.0" 1 "student"

    putStrLn "\n4. Testing Teacher-Student relations"
    insertRelation conn 1 1

    putStrLn "\n5. Testing Demonstrations"
    let demoDate = fromGregorian 2024 12 1
    insertDemo conn 1 demoDate 50
    updateDemo conn 1 1 demoDate 75

    putStrLn "\n6. Testing Seminars"
    let seminarDate = fromGregorian 2024 11 10
    insertSeminar conn "Functional Programming Seminar" seminarDate 100
    updateSeminar conn 1 "Updated Functional Programming Seminar" seminarDate 120

    putStrLn "\n7. Testing Software Packages tests lessons"
    let testDate = fromGregorian 2024 12 5
    insertTest conn 1 testDate 90
    updateTest conn 1 1 testDate 95

    putStrLn "\nAll tests operations done successfully."

    close conn