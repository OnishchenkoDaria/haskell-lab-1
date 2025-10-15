{-# LANGUAGE OverloadedStrings #-}

module Database.Seminars
  ( insertSeminar
  , updateSeminar
  ) where

import Database.SQLite.Simple
import Database.Helpers (dayToText)
import Data.Time.Calendar (Day)

insertSeminar :: Connection -> String -> Day -> Int -> IO ()
insertSeminar conn topic date audience = do
    _ <- execute conn
        "INSERT INTO seminars (topic, date, audience) VALUES (?, ?, ?)"
        (topic, dayToText date, audience)
    putStrLn "Seminar inserted"

updateSeminar :: Connection -> Int -> String -> Day -> Int -> IO ()
updateSeminar conn sid topic date audience = do
    _ <- execute conn
        "UPDATE seminars SET topic = ?, date = ?, audience = ? WHERE id = ?"
        (topic, dayToText date, audience, sid)
    putStrLn "Seminar updated"