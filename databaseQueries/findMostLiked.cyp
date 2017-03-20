//Return popular posts with > 5000 likes
MATCH (n:Post) where n.likes > 5000
return n
