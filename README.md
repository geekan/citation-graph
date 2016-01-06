# citation-graph
Citations are like a graph, follow the history, citations show how knowledge inherited.  
引用是一个图谱，它告诉了我们知识是如何传承的。

This project:  
* Crawl paper-pdfs and analyse them.
* Generate citation graph to show the relations of citations.

Concept graph:  
![citation-graph-demo](https://raw.githubusercontent.com/geekan/citation-graph/master/citation-graph.png)

Byproduct:
```
mysql> select * from stat_citations limit 24;
+---------------------------------------------------------------------------------+----------+----+
| title                                                                           | count(*) | id |
+---------------------------------------------------------------------------------+----------+----+
| Probabilistic Reasoning in Intelligent Systems: Networks of Plausible Inference |      106 |  1 |
| A Mathematical Theory of Evidence                                               |       93 |  2 |
| Reinforcement learning: An introduction                                         |       76 |  3 |
| Probabilistic Reasoning in Intelligent Systems                                  |       69 |  4 |
| The stable model semantics for logic programming                                |       53 |  5 |
| Elements of Information Theory                                                  |       50 |  6 |
| A logic for default reasoning                                                   |       47 |  7 |
| Dynamic Programming                                                             |       43 |  8 |
| Graphical models                                                                |       41 |  9 |
| Fuzzy sets                                                                      |       38 | 10 |
| Evaluating influence diagrams                                                   |       37 | 11 |
| Computational Complexity                                                        |       37 | 12 |
| Neural Networks for Pattern Recognition                                         |       35 | 13 |
| C4.5: programs for machine learning                                             |       35 | 14 |
| Artificial Intelligence: A Modern Approach                                      |       33 | 15 |
| planning through planning graph analysis                                        |       31 | 16 |
| Negation as failure                                                             |       31 | 17 |
| Foundations of Logic Programming                                                |       30 | 18 |
| Classical negation in logic programs and disjunctive databases                  |       30 | 19 |
| Statistical Learning Theory                                                     |       29 | 20 |
| The nature of statistical learning theory                                       |       29 | 21 |
| The Foundations of Statistics                                                   |       28 | 22 |
| Theory of Games and Economic Behavior                                           |       27 | 23 |
| A mathematical theory of communication                                          |       27 | 24 |
+---------------------------------------------------------------------------------+----------+----+
```
