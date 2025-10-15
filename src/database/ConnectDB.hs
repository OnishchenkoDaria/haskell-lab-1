{-# LANGUAGE OverloadedStrings #-}

module Database.ConnectDB
  ( connectDB
  ) where

import Database.SQLite.Simple

connectDB :: IO Connection
connectDB = do
    conn <- open "Software_Package_Development_University.db"
    -- enable foreign keys
    execute_ conn "PRAGMA foreign_keys = ON;"
    putStrLn "Connected to SQLite database"
    return conn