//Match single page to all the posts and create relationship among all
MATCH (p:Page), (m:Post)
CREATE (p)-[:posted]->(m)
