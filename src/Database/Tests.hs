{-# LANGUAGE OverloadedStrings #-}

module Database.Tests
  ( insertTest
  , updateTest
  ) where

import Database.SQLite.Simple
import Database.Helpers (dayToText)
import Data.Time.Calendar (Day)

insertTest :: Connection -> Int -> Day -> Int -> IO ()
insertTest conn packageId testDate result = do
    _ <- execute conn
        "INSERT INTO tests (package_id, test_date, result) VALUES (?, ?, ?)"
        (packageId, dayToText testDate, result)
    putStrLn "Test inserted"

updateTest :: Connection -> Int -> Int -> Day -> Int -> IO ()
updateTest conn tid packageId testDate result = do
    _ <- execute conn
        "UPDATE tests SET package_id = ?, test_date = ?, result = ? WHERE id = ?"
        (packageId, dayToText testDate, result, tid)
    putStrLn "Test updated"
