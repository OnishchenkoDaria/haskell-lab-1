{-# LANGUAGE OverloadedStrings #-}

module Database.Demonstrations
  ( insertDemo
  , updateDemo
  ) where

import Database.SQLite.Simple
import Database.Helpers (dayToText)
import Data.Time.Calendar (Day)

insertDemo :: Connection -> Int -> Day -> Int -> IO ()
insertDemo conn packageId date audience = do
    _ <- execute conn
        "INSERT INTO demonstrations (package_id, date, audience) VALUES (?, ?, ?)"
        (packageId, dayToText date, audience)
    putStrLn "Demonstration inserted"

updateDemo :: Connection -> Int -> Int -> Day -> Int -> IO ()
updateDemo conn did packageId date audience = do
    _ <- execute conn
        "UPDATE demonstrations SET package_id = ?, date = ?, audience = ? WHERE id = ?"
        (packageId, dayToText date, audience, did)
    putStrLn "Demonstration updated"
