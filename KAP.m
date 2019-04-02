%%%%%%%%%%%% Kinetic Analyisi Program %%%%%%%%%%%%%%
% main script to start the kinetic analysis
% of a multibody system
clearvars
close all

%
%... Define the memory structure
global time Flag;

%
%... Read and Pre-Process the Modelling Data
ReadInputData

%
%... Perform kinematic analysis
KinematicAnalysis

%%revolute 5,7; simple,drive 13, big structure 12
%% revrev 11; trans 10; pos analysis 9
