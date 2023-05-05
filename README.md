# A* Search Algorithm


## Description
The A* search algorithm is a widely used algorithm in artificial intelligence and computer science for finding the shortest path between two points in a graph. It is an informed search algorithm that is both complete (guaranteed to find a solution if one exists) and optimal (guaranteed to find the shortest path).

A* combines the advantages of both breadth-first search and heuristic search algorithms by using a heuristic function to estimate the cost of reaching the goal from a particular node. The algorithm then explores the nodes in the order of their estimated cost to reach the goal.

The heuristic function used in A* must be admissible, meaning that it never overestimates the true cost of reaching the goal. When the heuristic function is admissible, A* is guaranteed to find the shortest path between the starting node and the goal node.

To implement A*, we start by initializing the starting node and the goal node. We maintain a priority queue of nodes to be explored, sorted by their estimated cost to reach the goal. We then repeatedly extract the node with the lowest estimated cost from the priority queue and explore its neighbors, updating their estimated costs and adding them to the priority queue if necessary.

When we reach the goal node, we have found the shortest path. A* then returns the path from the starting node to the goal node by backtracking from the goal node through its parent nodes until we reach the starting node.

## Software pre-requisite
- MATLAB or Python

## Operation
### MATLAB
- Download the files inside the MATLAB folder
- Run "main.m"
- Load different map to show the effectiveness of the algorithm

## Results
<img src="https://github.com/TanJunKiat/A-star-Search/blob/main/images/map_1.jpeg" width=40% height=40%> <img src="https://github.com/TanJunKiat/A-star-Search/blob/main/images/map_2.jpeg" width=40% height=40%>
<img src="https://github.com/TanJunKiat/A-star-Search/blob/main/images/map_3.jpeg" width=40% height=40%> <img src="https://github.com/TanJunKiat/A-star-Search/blob/main/images/map_4.jpeg" width=40% height=40%>

## Discussion

## Troubleshooting

## Upcoming features / improvements
- Maintaining a certain distance from the wall

## Appendix 

### Pseudo code explanation

## References
1. [Wikipedia](https://en.wikipedia.org/wiki/A*_search_algorithm)

## Contact
Tan Jun Kiat (tanjunkiat@outlook.sg)
