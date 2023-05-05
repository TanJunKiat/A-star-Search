%% Clear all plots, workspace and command panel
close all
clear all
clc

%% Load pre-generated mapping
load("map_1.mat")

%% Run A*Star algorithm

% Enable to show the iterative process of the algorithm
% Disable to show the results + the path immediately
debug_flag = false; 

[bool] = AStarGrid (layout, start, goal, debug_flag);


