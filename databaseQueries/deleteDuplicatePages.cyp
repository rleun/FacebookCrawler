//Delete duplicate nodes
MATCH (p:Page)
WITH p.id as id, collect(p) AS nodes
WHERE size(nodes) >  1
FOREACH (p in tail(nodes) | DELETE p);
