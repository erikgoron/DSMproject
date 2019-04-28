clearvars;
close all;

%CONFIGURATION
% chose *.kap format: with or without composite joints (RevRev and
% RevTrans)
useCompositeJoints=false;

% .... ANIMATION
%how many times to repeat
repeatAnimation=5;
%option to play animation frame by frame by pressing enter
frameByFrame=false;
%animation speed, default = 1= realtime
frameDelay=0.1; %or manually set tstep after reading input data

%.... Input Data
%specify simulation input data (optional)
%if you don't specify Filename, a dialog to choose a file will appear
%Filename='sample_data/rower4_kap_v2.kap';
Filename='sample_data/4BAR.KAP';

% how to load the simulation results: 
% 1. use "import data" feature of matlab, chose *.* (All files) in file
% type, then chose your *.PLT output file. 
% 2. Import it as numerical matrix, set the table title (=variable name) to
% plt, then save the variable plt in a *.mat file by right click
% then load them in START_HERE.m with 
%load('sample_data/plt_rower4.mat');
%load('sample_data/positions_test1.mat');
load('sample_data/plt4bar.mat');

fromPlt=true;
fromPositions=false;

%plt=Positions';
ReadInputData
plotter_bodypoints
plotter_timeseries

%stop animation anytime with Ctrl+C