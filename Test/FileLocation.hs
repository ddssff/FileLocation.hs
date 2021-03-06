{-# LANGUAGE TemplateHaskell #-}
module Test.FileLocation where

import qualified Test.HUnit as HUnit
import Language.Haskell.TH
import FileLocation (locationToString)
import Control.Monad.IO.Class (liftIO)

-- | A version of assertEqual that gives location information.
assertEq :: Q Exp
assertEq = do
  loc <- location
  let prefix = locationToString loc ++ " "
  [|(\x -> HUnit.assertEqual prefix x)|]

-- | a MonadIO version of assertBool that gives location information.
assertB :: Q Exp
assertB = do
  loc <- location
  let prefix = locationToString loc ++ "assertB "
  [|(HUnit.assertBool prefix)|]

-- | Same as 'assertEq', but uses 'liftIO'
assertEq' :: Q Exp
assertEq' = do
  loc <- location
  let prefix = locationToString loc ++ " "
  [|(\x -> liftIO . HUnit.assertEqual prefix x)|]

-- | Same as 'assertB, but uses 'liftIO'
assertB' :: Q Exp
assertB' = do
  loc <- location
  let prefix = locationToString loc ++ "assertB "
  [|(liftIO . HUnit.assertBool prefix)|]
