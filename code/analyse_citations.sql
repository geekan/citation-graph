-- 数据 --

-- 进入mysql，注意local infile要使能
mysql -Dcitationsdb -p --local-infile=1

-- 创建表格，用于存储xml映射
CREATE TABLE arxiv_1000 (id varchar(64),updated varchar(64),published varchar(64),title varchar(256),summary varchar(256))
CREATE TABLE arxiv_ai (id varchar(64),updated varchar(64),published varchar(64),title varchar(256),summary varchar(256));

-- load xml文件
LOAD XML LOCAL INFILE 'xml_1000' INTO TABLE arxiv_ai ROWS IDENTIFIED BY '<entry>';
 xml_0_2000

LOAD XML LOCAL INFILE 'xml_0_2000' INTO TABLE  arxiv_ai   ROWS IDENTIFIED BY '<entry>';
LOAD XML LOCAL INFILE 'xml_2000_4000' INTO TABLE arxiv_ai  ROWS IDENTIFIED BY '<entry>';
LOAD XML LOCAL INFILE 'xml_4000_6000' INTO TABLE arxiv_ai  ROWS IDENTIFIED BY '<entry>';
LOAD XML LOCAL INFILE 'xml_6000_8000' INTO TABLE arxiv_ai  ROWS IDENTIFIED BY '<entry>';
LOAD XML LOCAL INFILE 'xml_8000_10000' INTO TABLE arxiv_ai  ROWS IDENTIFIED BY '<entry>';

-- 生成中间表

drop table mid_arxiv_ai;
CREATE TABLE mid_arxiv_ai AS
SELECT id, updated, published, title, summary, substring_index(a.id, '/', -1) as pdf
FROM arxiv_ai a;

drop table mid_citations;
CREATE TABLE mid_citations AS
SELECT id,title,booktitle,journal,volume,pages,author1,author2,author3,author4,author5,citedby,
substring_index(substring_index(b.citedby, '/', -1), '.pdf', 1) as pdf
from citations b;

-- JOIN 两表，根据ID和文件名来JOIN
DROP TABLE citations_a;
CREATE TABLE citations_a
AS SELECT a.title as maintitle, a.id as absurl, b.*
from mid_arxiv_ai a join mid_citations b
on a.pdf = b.pdf;

DROP TABLE citations_b;
CREATE TABLE citations_b
AS SELECT a.title as maintitle, a.id as absurl, b.*
from mid_arxiv_ai a right join mid_citations b
on (a.pdf = b.pdf)
WHERE a.pdf IS NULL;

-- 可以匹配上所有URL和PDF
DROP TABLE citations_c;
CREATE TABLE citations_c
AS SELECT a.title as maintitle, a.id as absurl, b.*
from mid_arxiv_ai a join mid_citations b
on (a.pdf like concat(b.pdf, '%'));

-- 查看结果，是否有多个相同的引文

select title, count(*) from citations_c group by title order by count(*) desc limit 20;
create table stat_citations as select title, count(*) from citations_c group by title order by count(*) desc;
select * from stat_citations limit 10;

create table nodes as select title from arxiv_ai;
ALTER TABLE nodes ADD id INT PRIMARY KEY AUTO_INCREMENT;
ALTER IGNORE TABLE nodes ADD UNIQUE (title);

-- 先转换主标题的ID
CREATE TABLE mid_cc1 AS SELECT a.id, b.title from nodes a JOIN citations_c b ON a.title=b.maintitle;
-- 再转换citation的ID
CREATE TABLE mid_cc2 AS SELECT b.id as src, a.id as dst from nodes a JOIN mid_cc1 b ON a.title=b.title;

-- 转换为CSV
SELECT id, title
FROM nodes
INTO OUTFILE '/tmp/nodes.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT dst, src
FROM edges
INTO OUTFILE '/tmp/edges.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT dst, src FROM edges WHERE src < 10000
INTO OUTFILE '/tmp/edges.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
