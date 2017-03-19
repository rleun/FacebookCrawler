//Clear database
MATCH(n)
OPTIONAL MATCH (n)-[r]-()
DELETE n,r


LOAD CSV WITH HEADERS FROM "file:///C:/abc7news_facebook_statuses.csv" AS line
CREATE (:Post {	message: toString(line.status_message)});


CREATE (:Page {name: "abc7news", id: toInteger(line.status_id)});
MERGE (page:Page)
ON MATCH SET page.id =  RETURN person.name, person.found


//Delete duplicate relations
MATCH (p:Page)
WITH p.id as id, collect(p) AS nodes
WHERE size(nodes) >  1
UNWIND tail(nodes) as tails
MATCH (tails)-[r]-()
DELETE r

LOAD CSV WITH HEADERS FROM "file:///C:/abc7news_facebook_statuses.csv" AS line
CREATE (:Page {name: "abc7news", id: toInteger(line.status_id)})
//Delete duplicate nodes
MATCH (p:Page)
WITH p.id as id, collect(p) AS nodes
WHERE size(nodes) >  1
FOREACH (p in tail(nodes) | DELETE p)


MATCH (p:Page), (m:Post)
CREATE (p)-[:posted]->(m)


LOAD CSV WITH HEADERS FROM "file:///C:/abc7news_facebook_statuses.csv" AS line
CREATE p = (:Post {	message: toString(line.status_message)})
p-[:has]->(:Statistics { likes: toInteger(line.num_likes)})
p-[:has]->(:Statistics { comments: toInteger(line.num_comments)})


LOAD CSV WITH HEADERS FROM "file:///C:/abc7news_facebook_statuses.csv" AS line
CREATE (:Statistics {	likes: toInteger(line.num_likes)})
