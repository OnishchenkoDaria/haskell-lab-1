{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.ConnectDB
import Database.Queries
import Data.Time (fromGregorian)
import Control.Exception (catch, SomeException)
import Control.Monad (void)

main :: IO ()
main = do
    conn <- connectDB
    putStrLn "Test scenario"
    let safeRun action desc = catch action (\e -> putStrLn $ "Error in " ++ desc ++ ": " ++ show (e :: SomeException))

    safeRun (insertStudent conn "Alice Brown" "CS-21" "alice@example.com") "insertStudent 1"
    safeRun (insertStudent conn "Bob Carter" "CS-22" "bob@example.com") "insertStudent 2"

    safeRun (updateStudent conn 1 "Alice B." "CS-21" "aliceb@updated.com") "updateStudent 1"

    safeRun (insertTeacher conn "Dr. Smith" "Computer Science" "smith@example.com") "insertTeacher 1"
    safeRun (insertTeacher conn "Prof. Evans" "Mathematics" "evans@example.com") "insertTeacher 2"

    safeRun (updateTeacher conn 2 "Prof. E. Evans" "Applied Math" "evans_updated@example.com") "updateTeacher 2"

    safeRun (insertRelation conn 1 1) "insertRelation (Alice–Smith)"
    safeRun (insertRelation conn 2 2) "insertRelation (Bob–Evans)"

    safeRun (insertSoftwarePackage conn "HaskellApp" "Functional demo app" "1.0" 1 "student") "insertSoftwarePackage 1"
    safeRun (insertSoftwarePackage conn "MathSuite" "Numerical tools" "2.3" 2 "teacher") "insertSoftwarePackage 2"

    safeRun (updateSoftwarePackage conn 1 "HaskellApp" "Improved FP demo app" "1.1" 1 "student") "updateSoftwarePackage 1"
    safeRun (updateSoftwarePackage conn 2 "MathSuite Pro" "Advanced numerical tools" "3.0" 2 "teacher") "updateSoftwarePackage 2"

    safeRun (insertSeminar conn "Functional Programming Seminar" (fromGregorian 2025 11 5) 80) "insertSeminar 1"
    safeRun (insertSeminar conn "Advanced Math Workshop" (fromGregorian 2025 12 15) 100) "insertSeminar 2"

    safeRun (insertDemo conn 1 (fromGregorian 2025 11 10) 60) "insertDemo 1 (for HaskellApp)"
    safeRun (insertDemo conn 2 (fromGregorian 2025 12 20) 120) "insertDemo 2 (for MathSuite)"

    safeRun (updateDemo conn 2 2 (fromGregorian 2025 12 22) 150) "updateDemo 2"

    safeRun (insertTest conn 1 (fromGregorian 2025 11 15) 85) "insertTest 1 (HaskellApp)"
    safeRun (insertTest conn 2 (fromGregorian 2025 12 25) 92) "insertTest 2 (MathSuite)"

    safeRun (updateTest conn 1 1 (fromGregorian 2025 11 15) 95) "updateTest 1"

    putStrLn "\n Test scenario complete"