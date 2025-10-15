{-# LANGUAGE OverloadedStrings #-}

module Database.Helpers
  ( dayToText
  ) where

import Data.Time.Calendar (Day)
import Data.Time.Format (formatTime, defaultTimeLocale)
import Data.Text (Text, pack)

dayToText :: Day -> Text
dayToText = pack . formatTime defaultTimeLocale "%F"