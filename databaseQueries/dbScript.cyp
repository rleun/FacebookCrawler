//Load CSV
LOAD CSV WITH HEADERS FROM "file:///C:/abc7news_facebook_statuses.csv" AS line

//Create nodes for each
CREATE (page:Page {name: "abc7news", id: toInteger(line.status_id)})

//Post Node
CREATE (post:Post {	message: toString(line.status_message), linkName: toString(line.link_name), statuslink: toString(line.status_link)})

//Timestamp Node
CREATE (timestamp:Timestamp {	timestamp: toInteger(line.num_likes)})

//Statistic Nodes
CREATE (likes:Statistics {	likes: toInteger(line.num_likes)})
CREATE (comments:Statistics {	comments: toInteger(line.num_comments)})
CREATE (reactions:Statistics {	reactions: toInteger(line.num_reactions)})
CREATE (shares:Statistics {	shares: toInteger(line.num_shares)})
CREATE (loves:Statistics {	loves: toInteger(line.num_loves)})
CREATE (wows:Statistics {	wows: toInteger(line.num_wows)})
CREATE (hahas:Statistics {	hahas: toInteger(line.num_hahas)})
CREATE (sads:Statistics {	sads: toInteger(line.num_sads)})
CREATE (angrys:Statistics {	angrys: toInteger(line.num_angrys)})

//Create relationships
CREATE (page)-[:Posted]->(post)

CREATE (post)-[:Created_On]->(timestamp)

CREATE (post)-[:Has]->(reactions)
CREATE (post)-[:Has]->(comments)
CREATE (post)-[:Has]->(shares)
CREATE (post)-[:Has]->(likes)
CREATE (post)-[:Has]->(loves)
CREATE (post)-[:Has]->(wows)
CREATE (post)-[:Has]->(hahas)
CREATE (post)-[:Has]->(sads)
CREATE (post)-[:Has]->(angrys);


//Delete duplicate nodes
MATCH (p:Page)
WITH p.id as id, collect(p) AS nodes
WHERE size(nodes) >  1
FOREACH (p in tail(nodes) | DELETE p);

//Match single page to all the posts and create relationship among all
MATCH (p:Page), (m:Post)
CREATE (p)-[:posted]->(m)
