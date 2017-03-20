//Return keywords where more than 25 posts have mentioned
MATCH (Keyword)<-[z:Mentions]-(:Post)
WITH Keyword, count(*) as posts
where posts > 25
return Keyword, posts
