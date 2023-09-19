import heapq

class Node:
    def __init__(self, parent=None, position=None):
        self.parent = parent
        self.position = position
        self.g = 0  # Cost from start node to current node
        self.h = 0  # Heuristic estimate from current node to goal node
        self.f = 0  # Total cost: g + h

    def __lt__(self, other):
        return self.f < other.f

def astar(grid, start, end):
    open_set = []
    closed_set = set()
    
    start_node = Node(None, start)
    end_node = Node(None, end)
    
    heapq.heappush(open_set, start_node)
    
    while open_set:
        current_node = heapq.heappop(open_set)
        
        if current_node.position == end_node.position:
            path = []
            while current_node is not None:
                path.append(current_node.position)
                current_node = current_node.parent
            return path[::-1]  # Return reversed path
        
        closed_set.add(current_node.position)
        
        for neighbor in [(0, 1), (0, -1), (1, 0), (-1, 0)]:  # Adjacent cells
            neighbor_position = (current_node.position[0] + neighbor[0], current_node.position[1] + neighbor[1])
            
            if (
                neighbor_position[0] < 0 or neighbor_position[0] >= len(grid) or
                neighbor_position[1] < 0 or neighbor_position[1] >= len(grid[0]) or
                grid[neighbor_position[0]][neighbor_position[1]] == 1
            ):
                continue  # Skip invalid neighbors
            
            neighbor_node = Node(current_node, neighbor_position)
            
            if neighbor_node.position in closed_set:
                continue  # Skip visited neighbors
            
            neighbor_node.g = current_node.g + 1
            neighbor_node.h = abs(neighbor_node.position[0] - end_node.position[0]) + abs(neighbor_node.position[1] - end_node.position[1])
            neighbor_node.f = neighbor_node.g + neighbor_node.h
            
            if any(neighbor_node == node for node in open_set):
                continue  # Skip if a better path already exists
                
            heapq.heappush(open_set, neighbor_node)
    
    return None  # No path found

# Example usage:
grid = [
    [0, 0, 0, 0, 0],
    [1, 1, 0, 1, 0],
    [0, 0, 0, 0, 0],
    [0, 1, 1, 1, 1],
    [0, 0, 0, 0, 0]
]
start = (0, 0)
end = (4, 4)
path = astar(grid, start, end)

if path:
    print("Path found:", path)
else:
    print("No path found")
