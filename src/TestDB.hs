{-# LANGUAGE OverloadedStrings #-}

module TestDB
  ( runTestMenu
  ) where

import Database.SQLite.Simple
import Database.ConnectDB
import Database.Helpers (dayToText)
import Database.Demonstrations
import Database.Seminars
import Database.SoftwarePackages
import Database.Students
import Database.StudentTeacherRelate
import Database.Teachers
import Database.Tests

import Data.Time.Calendar (Day, fromGregorian)
import Control.Monad (forever)
import System.IO (hFlush, stdout)
import System.Exit (exitSuccess)

-- | Read a line from console with prompt
prompt :: String -> IO String
prompt text = do
    putStr text
    putStr " "
    hFlush stdout
    getLine

-- | Parse a date as YYYY-MM-DD
readDay :: String -> Day
readDay str =
    let [yStr,mStr,dStr] = words $ map (\c -> if c=='-' then ' ' else c) str
        y = read yStr :: Integer
        m = read mStr :: Int
        d = read dStr :: Int
    in fromGregorian y m d

-- | Run the menu loop
runTestMenu :: IO ()
runTestMenu = do
    conn <- connectDB
    forever $ do
        putStrLn "\nSelect an action:"
        putStrLn "1. Insert Student"
        putStrLn "2. Update Student"
        putStrLn "3. Insert Teacher"
        putStrLn "4. Update Teacher"
        putStrLn "5. Insert Software Package"
        putStrLn "6. Update Software Package"
        putStrLn "7. Insert Seminar"
        putStrLn "8. Update Seminar"
        putStrLn "9. Insert Demonstration"
        putStrLn "10. Update Demonstration"
        putStrLn "11. Insert Test"
        putStrLn "12. Update Test"
        putStrLn "13. Insert Student-Teacher Relation"
        putStrLn "0. Exit"
        choice <- prompt "Enter choice:"
        case choice of
            "1" -> do
                name <- prompt "Student name:"
                group <- prompt "Group:"
                email <- prompt "Email:"
                insertStudent conn name group email
            "2" -> do
                sid <- read <$> prompt "Student ID:"
                name <- prompt "Student name:"
                group <- prompt "Group:"
                email <- prompt "Email:"
                updateStudent conn sid name group email
            "3" -> do
                name <- prompt "Teacher name:"
                dept <- prompt "Department:"
                email <- prompt "Email:"
                insertTeacher conn name dept email
            "4" -> do
                tid <- read <$> prompt "Teacher ID:"
                name <- prompt "Teacher name:"
                dept <- prompt "Department:"
                email <- prompt "Email:"
                updateTeacher conn tid name dept email
            "5" -> do
                title <- prompt "Package title:"
                desc <- prompt "Description:"
                version <- prompt "Version:"
                authorId <- read <$> prompt "Author ID:"
                authorType <- prompt "Author type (student/teacher):"
                insertSoftwarePackage conn title desc version authorId authorType
            "6" -> do
                pid <- read <$> prompt "Package ID:"
                title <- prompt "Package title:"
                desc <- prompt "Description:"
                version <- prompt "Version:"
                authorId <- read <$> prompt "Author ID:"
                authorType <- prompt "Author type (student/teacher):"
                updateSoftwarePackage conn pid title desc version authorId authorType
            "7" -> do
                topic <- prompt "Seminar topic:"
                dateStr <- prompt "Date (YYYY-MM-DD):"
                audience <- read <$> prompt "Audience:"
                insertSeminar conn topic (readDay dateStr) audience
            "8" -> do
                sid <- read <$> prompt "Seminar ID:"
                topic <- prompt "Seminar topic:"
                dateStr <- prompt "Date (YYYY-MM-DD):"
                audience <- read <$> prompt "Audience:"
                updateSeminar conn sid topic (readDay dateStr) audience
            "9" -> do
                pid <- read <$> prompt "Package ID:"
                dateStr <- prompt "Date (YYYY-MM-DD):"
                audience <- read <$> prompt "Audience:"
                insertDemo conn pid (readDay dateStr) audience
            "10" -> do
                did <- read <$> prompt "Demo ID:"
                pid <- read <$> prompt "Package ID:"
                dateStr <- prompt "Date (YYYY-MM-DD):"
                audience <- read <$> prompt "Audience:"
                updateDemo conn did pid (readDay dateStr) audience
            "11" -> do
                pid <- read <$> prompt "Package ID:"
                dateStr <- prompt "Test date (YYYY-MM-DD):"
                result <- read <$> prompt "Result (1-100):"
                insertTest conn pid (readDay dateStr) result
            "12" -> do
                tid <- read <$> prompt "Test ID:"
                pid <- read <$> prompt "Package ID:"
                dateStr <- prompt "Test date (YYYY-MM-DD):"
                result <- read <$> prompt "Result (1-100):"
                updateTest conn tid pid (readDay dateStr) result
            "13" -> do
                sid <- read <$> prompt "Student ID:"
                tid <- read <$> prompt "Teacher ID:"
                insertRelation conn sid tid
            "0" -> do
                putStrLn "Exiting..."
                close conn
                exitSuccess
            _ -> putStrLn "Invalid choice, try again."