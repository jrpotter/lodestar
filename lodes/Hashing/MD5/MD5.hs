{-# LANGUAGE ViewPatterns #-}

import Data.Bits
import Data.Word
import Data.Int (Int64)
import Control.Monad.State
import qualified Data.ByteString.Lazy as B

-- Conversion Methods
toByteString :: String -> B.ByteString
toByteString b = B.pack $ map (toEnum . fromEnum) b

toString :: B.ByteString -> String
toString b = map (toEnum . fromEnum) (B.unpack b)

toWord8 :: Int64 -> [Word8]
toWord8 n = map (fromIntegral . transform) [0, 8..56]
    where mask = (.&.) 0xFF000000
          transform x = rotate (mask $ shift n x) 8

toWord32 :: B.ByteString -> [Word32]
toWord32 (B.uncons -> Nothing) = []
toWord32 b = trans (B.unpack $ B.take 4 b) : toWord32 (B.drop 4 b)
    where trans [] = 0
          trans (w:ws) = let b' = trans ws
                         in rotateR (b' .|. fromIntegral w) 8

-- Convert string to bytes with length (mod 512)
pad :: String -> B.ByteString
pad s = let b = B.snoc (toByteString s) 1
            l = 8 * B.length b
            r = 448 + 512 * (l `quot` 448) - l
            m = B.append b (B.take (r `quot` 8) (B.repeat 0))
        in B.append m (B.pack . toWord8 $ l - 8)

-- Functions for futher processing after padding
proc :: Int -> Word32 -> Word32 -> Word32 -> Word32
proc n x y z 
    | n <= 15 = (x .&. y) .|. (z .&. complement x)
    | n <= 31 = (x .&. z) .|. (y .&. complement z)
    | n <= 47 = x `xor` y `xor` z
    | otherwise = y `xor` (x .|. complement z)

-- Index functions
index :: Word32 -> Word32
index n 
    | n <= 15 = n
    | n <= 31 = (5 * n + 1) `mod` 16
    | n <= 47 = (3 * n + 5) `mod` 16
    | otherwise = (7 * n) `mod` 16

-- Rotations
rotations :: [Word32]
rotations = concat $ replicate 4 =<< [[7, 12, 17, 22], [5, 9, 14, 20]
                                     ,[4, 11, 16, 23], [6, 10, 15, 21]]

-- Other Constants
table = [x | y <- [1..64], let x = floor $ (abs . sin) y * 2^32]
words = [0x01234567, 0x89abcdef, 0xfedcba98, 0x76543210] :: [Word32]

-- Main Digestion Algorithm

-- Return hex string representation of 128-bit digest
--md5 :: String -> String
--md5 = toChars . digest . pad
