xxx ="https://s.alicdn.com/@sc01/kf/HTB1QrYjbRKw3KVjSZTEq6AuRpXaV/6-in-1-Multifunction-Digital-Watch-Altimeter.jpg_300x300.jpg"

# yyyはxxxの前方70文字のことを指す = つまりxxxは残りの後方の文字を指す事になる
# yyy = xxx[0..69]


zzz = xxx.slice!(0..69)

puts xxx

puts zzz

puts zzz + xxx


# return if xxx[0..69] == yyy