{-# LANGUAGE OverloadedStrings #-}

module Database.ConnectDB
  ( connectDB
  ) where

import Database.MySQL.Simple

connectDB :: IO Connection
connectDB = do
  let connInfo = defaultConnectInfo
        { connectHost     = "127.0.0.1"
        , connectUser     = "root"
        , connectPassword = "password"
        , connectDatabase = "Software_Package_Development_University"
        , connectPort     = 3306
        }
  conn <- connect connInfo
  putStrLn "Connected to database"
  return conn