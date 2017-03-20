//Load CSV
USING PERIODIC COMMIT 100
LOAD CSV WITH HEADERS FROM "file:///C:/10kPosts.csv" AS line
WITH line LIMIT 1000


//Create Page Node
MERGE (page:Page {name: toString(line.page_name)})


//Post Node
CREATE (post:Post {	message: toString(line.status_message), linkName: toString(line.link_name), statuslink: toString(line.status_link), statusID:toInteger(line.status_id), likes: toInteger(line.num_likes), comments: toInteger(line.num_comments), reactions: toInteger(line.num_reactions), shares: toInteger(line.num_shares), loves: toInteger(line.num_loves), wows: toInteger(line.num_wows), hahas: toInteger(line.num_hahas), sads: toInteger(line.num_sads), angrys: toInteger(line.num_angrys)})


//keyword nodes
FOREACH ( w IN filter(x IN SPLIT(line.status_message, " ") WHERE NOT lower(trim(x)) IN['-', '|', 'it\'s', '', 'as', 'getting','should','where', 'says','it','bit','was','the', 'a','to','an','like','of','become','feel','actually','her','he','them','they','she','his','hers','theirs','in', 'is','_', '-', '.','and', 'on', 'my', 'be', 'than', 'then', 'almost', 'more', 'The', 'a', 'has', 'been', 'Why', 'why', 'Is', 'this', 'This', 'about', 'by', 'Don\'t', 'don\'t', 'from', 'with', 'From', 'With', 'those','the', 'of', 'to', 'and', 'a', 'in', 'is', 'it', 'you', 'that', 'he', 'was', 'for', 'on', 'are', 'with', 'as', 'I', 'his', 'they', 'be', 'at', 'one', 'have', 'this', 'from', 'or', 'had', 'by', 'hot', 'word', 'but', 'what', 'some', 'we', 'can', 'out', 'other', 'were', 'all', 'there', 'when', 'up', 'use', 'your', 'how', 'said', 'an', 'each', 'she', 'which', 'do', 'their', 'time', 'if', 'will', 'way', 'about', 'many', 'then', 'them', 'write', 'would', 'like', 'so', 'these', 'her', 'long', 'make', 'thing', 'see', 'him', 'two', 'has', 'look', 'more', 'day', 'could', 'go', 'come', 'did', 'number', 'sound', 'no', 'most', 'people', 'my', 'over', 'know', 'water', 'than', 'call', 'first', 'who', 'may', 'down', 'side', 'been', 'now', 'find', 'any', 'new', 'work', 'part', 'take', 'get', 'place', 'made', 'live', 'where', 'after', 'back', 'little', 'only', 'round', 'man', 'year', 'came', 'show', 'every', 'good', 'me', 'give', 'our', 'under', 'name', 'very', 'through', 'just', 'form', 'sentence', 'great', 'think', 'say', 'help', 'low', 'line', 'differ', 'turn', 'cause', 'much', 'mean', 'before', 'move', 'right', 'boy', 'old', 'too', 'same', 'tell', 'does', 'set', 'three', 'want', 'well', 'also', 'small', 'end', 'put', 'home', 'read', 'hand', 'port', 'add', 'even', 'land', 'here', 'must', 'big', 'high', 'such', 'follow', 'act', 'why', 'ask', 'change', 'went', 'light', 'kind', 'off', 'need', 'try', 'us', 'again','a', 'about', 'above', 'across', 'after', 'afterwards', 'again', 'against', 'all', 'almost', 'alone', 'along', 'already', 'also', 'although', 'always', 'am', 'among', 'amongst', 'amoungst', 'amount', 'an', 'and', 'another', 'any', 'anyhow', 'anyone', 'anything', 'anyway', 'anywhere', 'are', 'around', 'as', 'at', 'back', 'be', 'became', 'because', 'become', 'becomes', 'becoming', 'been', 'before', 'beforehand', 'behind', 'being', 'below', 'beside', 'besides', 'between', 'beyond', 'bill', 'both', 'bottom', 'but', 'by', 'call', 'can', 'cannot', 'cant', 'co', 'computer', 'con', 'could', 'couldnt', 'cry', 'de', 'describe', 'detail', 'do', 'done', 'down', 'due', 'during', 'each', 'eg', 'eight', 'either', 'eleven', 'else', 'elsewhere', 'empty', 'enough', 'etc', 'even', 'ever', 'every', 'everyone', 'everything', 'everywhere', 'except', 'few', 'fifteen', 'fify', 'fill', 'find', 'fire', 'first', 'five', 'for', 'former', 'formerly', 'forty', 'found', 'four', 'from', 'front', 'full', 'further', 'get', 'give', 'go', 'had', 'has', 'hasnt', 'have', 'he', 'hence', 'her', 'here', 'hereafter', 'hereby', 'herein', 'hereupon', 'hers', 'herself', 'him', 'himself', 'his', 'how', 'however', 'hundred', 'i', 'ie', 'if', 'in', 'inc', 'indeed', 'interest', 'into', 'is', 'it', 'its', 'itself', 'keep', 'last', 'latter', 'latterly', 'least', 'less', 'ltd', 'made', 'many', 'may', 'me', 'meanwhile', 'might', 'mill', 'mine', 'more', 'moreover', 'most', 'mostly', 'move', 'much', 'must', 'my', 'myself', 'name', 'namely', 'neither', 'never', 'nevertheless', 'next', 'nine', 'no', 'nobody', 'none', 'noone', 'nor', 'not', 'nothing', 'now', 'nowhere', 'of', 'off', 'often', 'on', 'once', 'one', 'only', 'onto', 'or', 'other', 'others', 'otherwise', 'our', 'ours', 'ourselves', 'out', 'over', 'own', 'part', 'per', 'perhaps', 'please', 'put', 'rather', 're', 'same', 'see', 'seem', 'seemed', 'seeming', 'seems', 'serious', 'several', 'she', 'should', 'show', 'side', 'since', 'sincere', 'six', 'sixty', 'so', 'some', 'somehow', 'someone', 'something', 'sometime', 'sometimes', 'somewhere', 'still', 'such', 'system', 'take', 'ten', 'than', 'that', 'the', 'their', 'them', 'themselves', 'then', 'thence', 'there', 'thereafter', 'thereby', 'therefore', 'therein', 'thereupon', 'these', 'they', 'thick', 'thin', 'third', 'this', 'those', 'though', 'three', 'through', 'throughout', 'thru', 'thus', 'to', 'together', 'too', 'top', 'toward', 'towards', 'twelve', 'twenty', 'two', 'un', 'under', 'until', 'up', 'upon', 'us', 'very', 'via', 'was', 'we', 'well', 'were', 'what', 'whatever', 'when', 'whence', 'whenever', 'where', 'whereafter', 'whereas', 'whereby', 'wherein', 'whereupon', 'wherever', 'whether', 'which', 'while', 'whither', 'who', 'whoever', 'whole', 'whom', 'whose', 'why', 'will', 'with', 'within', 'without', 'would', 'yet', 'you', 'your', 'yours', 'yourself', 'yourselves', 'going'] AND NOT lower(trim(x)) CONTAINS ',' AND NOT lower(trim(x)) CONTAINS '.' AND NOT lower(trim(x)) CONTAINS '\"' AND NOT lower(trim(x)) CONTAINS '?' AND NOT x CONTAINS '&' AND NOT x CONTAINS '(' AND NOT x CONTAINS '[' AND NOT x CONTAINS '_' AND NOT x CONTAINS '-' ) | MERGE (keyword:Keyword { word: lower(trim(w)) }) CREATE (post)-[:Mentions]->(keyword) )


//Timestamp Node
MERGE (timestamp:Timestamp {timestamp: (SPLIT(line.status_published, " ")[0])})

/*
//Status ID Node
CREATE (statusID:StatusID {	statusID: toInteger(line.status_id)})

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
*/
//Create relationships
CREATE (page)-[:Posted]->(post)

CREATE (post)-[:Created_On]->(timestamp)

/*
CREATE (post)-[:StatusID]->(statusID)

CREATE (post)-[:Has]->(reactions)
CREATE (post)-[:Has]->(comments)
CREATE (post)-[:Has]->(shares)
CREATE (post)-[:Has]->(likes)
CREATE (post)-[:Has]->(loves)
CREATE (post)-[:Has]->(wows)
CREATE (post)-[:Has]->(hahas)
CREATE (post)-[:Has]->(sads)
CREATE (post)-[:Has]->(angrys)
*/

;
