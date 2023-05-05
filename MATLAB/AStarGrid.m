function [bool] = AStarGrid (layout, start, goal, debug_flag)
% Run A* algorithm on a grid.
% Inputs :
%   input_map : a logical array where the freespace cells are false or 0 and
%   the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%   respectively, the first entry is the row and the second the column.
% Output :
%    route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route. This is a single dimensional vector
%    numExpanded: Remember to also return the total number of nodes
%    expanded during your search. Do not count the goal node as an expanded node.

%% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

cmap = [1 1 1; ...
    0 0 0; ...
    1 0 0; ...
    0 0 1; ...
    0 1 0; ...
    1 1 0; ...
    0.5 0.5 0.5];

colormap(cmap);

%%
[nrows, ncols] = size(layout);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~layout) = 1;   % Mark free cells
map(layout)  = 2;   % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start(1), start(2));
dest_node  = sub2ind(size(map), goal(1),  goal(2));

parent = zeros(nrows,ncols);

%% Heuristic function
% Creating mesh grid 
[X, Y] = meshgrid (1:ncols, 1:nrows);
% Evaluate Heuristic function, H, for each grid cell
fun = "manhattan";
switch(fun)
    case "manhattan"
        % Manhattan distance
        H = abs(X - goal(1)) + abs(Y - goal(2));
    case "euclidean"
        % Euclidean distance
        H = sqrt( (X - goal(1))^2 + (Y - goal(2))^2 );
end

%% Initialize cost arrays
F = Inf(nrows,ncols);
g = Inf(nrows,ncols);

g(start_node) = 0;
F(start_node) = H(start_node);

%% Main Loop

while true

    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;

    if (debug_flag)
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end

    % Find pixel with the minimum distance function value (F)
    [min_F, current] = min(F(:));

    if ((current == dest_node) || isinf(min_F))
        break;
    end;

    % Update input_map
    map(current) = 3;
    F(current) = Inf; % remove this node from further consideration

    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(F), current);

    % *********************************************************************
    % Calculate the current pixel's distance from the start point
    % Calculate the neighbouring pixel's distance from the start point

    % Check if:
    % 2. The neighbouring pixel is a visited
    % 3. The neighbouring pixel is the starting position
    if map(i+1,j) ~= 3 && map(i+1,j) ~= 5 && map(i+1,j) ~= 2 
        % Calculate the neighbouring pixel's distance from the start point
        
        % Check if:
        % 1. The distance of neighbour pixel is more than the current pixel
        % 2. The neighbouring pixel is a boundary / obstacle
        if g(i+1,j) > g(i,j) + 1
            g(i+1,j) = g(i,j) + 1;
            % Update new distance values
            F(i+1,j) = g(i+1,j) + H(i+1,j);
            % Record neighbouring pixel's index
            parent(i+1,j) = current;
            % Checked neighbouring pixel
            map(i+1,j) = 4;
        end
    end

    if  map(i-1,j) ~= 3 && map(i-1,j) ~= 5 && map(i-1,j) ~= 2 
        if g(i-1,j) > g(i,j) + 1
            g(i-1,j) = g(i,j) + 1;
            F(i-1,j) = g(i-1,j) + H(i-1,j);
            parent(i-1,j) = current;
            map(i-1,j) = 4;
        end
    end

    if map(i,j+1) ~= 3 && map(i,j+1) ~= 5 && map(i,j+1) ~= 2
        
        if g(i,j+1) > g(i,j) + 1
            g(i,j+1) = g(i,j) + 1;
            F(i,j+1) = g(i,j+1) + H(i,j+1);
            parent(i,j+1) = current;
            map(i,j+1) = 4;
        end
    end

    if map(i,j-1) ~= 3 && map(i,j-1) ~= 5 && map(i,j-1) ~= 2
        if g(i,j-1) > g(i,j) + 1
            g(i,j-1) = g(i,j) + 1;
            F(i,j-1) = g(i,j-1) + H(i,j-1);
            parent(i,j-1) = current;
            map(i,j-1) = 4;
        end
    end

    %*********************************************************************


end

%% Construct route from start to dest by following the parent links
if (isinf(F(dest_node)))
    route = [];
else
    route = [dest_node];

    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end

    % Snippet of code used to visualize the map and the path
    for k = 2:length(route) - 1
        map(route(k)) = 7;
        pause(0.1);
        image(1.5, 1.5, map);
        grid on;
        axis image;
    end
    bool = 1;
end

end
