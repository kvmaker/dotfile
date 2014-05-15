doubleMe x = x + x
doubleUs x y = x * x + y * y
doubleSmall x = if x >= 100
                then x
                else x * 2
boomBangs xs = [if x < 10 then "BOOM"
               else "BANG!"
               | x<-xs, odd x]

volumn r = 4.0/3.0 * pi * (cube r)
    where
      cube r = r * r * r

fact n = if (n == 0)
         then 1
         else n * fact(n -1)

fact' n | n == 0    = 1
        | otherwise = n * fact' (n -1)

fact'' 0 = 1
fact'' n = n * fact''(n -1)

checkVal x y | x > y     = 1
             | x < y     = -1
             | otherwise = 0

distance (x1, y1) (x2, y2) = sqrt(dx * dx + dy * dy)
    where
      dx = x1 - x2
      dy = y1 - y2

len [] = 0
len (_:xs) = 1 + len xs

last' [x] = x
last' (_:xs) = last xs 

max' [x] = x
max' (x:y:ys) | y > x     = max' (y:ys)
              | otherwise = max' (x:ys)

zip' (x:xs) (y:ys) = (x, y) : zip' xs ys
zip' _ _           = []

unzip' []         = ([], [])
unzip' ((x,y):ps) = (x:xs, y:ys)
                    where (xs, ys) = unzip' ps

removeDup' []  = []
removeDup' [x] = [x]
removeDup' (x:y:ps) | x == y    = removeDup'  (y:ps)
                    | otherwise = x:removeDup' (y:ps)

rem34 lab@(o:p:q:r:ps) | q==r      = (o:p:ps)
                       | otherwise = lab

map' f [] = []
map' f (x:xs) = (f x) : (map' f xs)

tupleList xs = map' (\x -> (0,x)) xs

sum' []     = 0
sum' (x:xs) = x + sum' xs

product' []     = 1
product' (x:xs) = x * product' xs

foldr' f b []     = b
foldr' f b (x:xs) = f x (foldr' f b xs)

filter' _ [] = []
filter' p (x:xs) | p x      = x : filter' p xs
                 | otherwise = filter' p xs

takewhile _ [] = []
takewhile p (x:xs) | p x = x : takewhile p xs
                   | otherwise = takewhile p xs

dropwhile _ [] = []
dropwhile p (x:xs) | p x = dropwhile p xs
                   | otherwise = x:dropwhile p xs
