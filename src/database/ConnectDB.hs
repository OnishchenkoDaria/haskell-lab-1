{-# LANGUAGE OverloadedStrings #-}

module ConnectDB where

import Database.MySQL.Simple

connectDB :: IO Connection
connectDB = connect defaultConnectInfo {
    connectHost     = "127.0.0.1",
    connectUser     = "root",
    connectPassword = "password",
    connectDatabase = "Software_Package_Development_University",
    connectPort     = 3306
}

testQuery :: IO ()
testQuery = do
    conn <- connectDB
    putStrLn "Connected to MySQL!"
    [Only i] <- query_ conn "SELECT 1 + 1"
    putStrLn $ "Test query result: " ++ show (i :: Int)
    close conn