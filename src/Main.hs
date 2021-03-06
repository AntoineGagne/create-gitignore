{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.ByteString.Lazy (ByteString)
import Data.List (intercalate)
import Network.HTTP.Client ( parseRequest
                           , newManager
                           , httpLbs
                           , responseBody
                           )
import Network.HTTP.Client.TLS (tlsManagerSettings)
import Options.Applicative

import qualified Data.ByteString.Lazy as ByteString
import qualified Data.ByteString.Lazy.Char8 as Char8
import Data.Monoid ((<>))

data Options = Options { optionCommand :: !Command }

data Command = Fetch [String]
             | List

main :: IO ()
main = do
    options <- execParser optionsParser
    case optionCommand options of
      Fetch tools -> fetchGitignore tools >>= Char8.putStrLn
      List -> listTools >>= Char8.putStrLn
    where
        optionsParser = info ( helper <*> 
                               versionOption <*> 
                               programOptions
                             )
                             ( fullDesc <>
                               progDesc "Create a .gitignore" <>
                               header "create-gitignore - A program that executes commands against the `gitignore.io` API."
                             )
        versionOption = infoOption "1.0.0.0" (long "version" <> help "Show version")
        programOptions = Options <$> hsubparser (listCommand <> fetchCommand)
        listCommand = command "list" (info (pure List) (progDesc "List the different options"))
        fetchCommand = command "fetch" (info fetchOptions (progDesc "Fetch the corresponding `.gitignore` from the API."))
        fetchOptions = Fetch <$> many (strArgument (metavar "TOOLS" <> help "Name of the different tools and languages used"))

fetchGitignore :: [String] -> IO ByteString
fetchGitignore tools = sendRequest fetchUrl
    where formattedTools = intercalate "," tools
          fetchUrl = apiUrl ++ formattedTools

listTools :: IO ByteString
listTools = sendRequest listUrl
    where listUrl = apiUrl ++ "list"

apiUrl :: String
apiUrl = "https://www.gitignore.io/api/"

sendRequest :: String -> IO ByteString
sendRequest url = do
    manager <- newManager tlsManagerSettings
    request <- parseRequest url
    responseBody <$> httpLbs request manager
