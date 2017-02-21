clear all;
close all;
clc;

%% Lab 1 : Modelling an IIR/FIR Filter

%Coefficients of this filter are already calculated from the fda tool
%Parameters are on slide 14 Lecture 2

%The coefficients are exported from the fda tool.Before the export,
%we are going to convert it to single section so that we will get
%the Num and Den constants
%% Signal Test Generation
nos = 1024;             %number of samples
x = zeros(1,nos);       %Creating an impulse response (delta dirac)
x(1) = 1;
%% Testbench IIR
load('BandPassIF.mat');         %Loading the parameters
y = filterIIR2t(x,Num,Den);  %Applying the filter response on the signal
SpectrumPlot(y);             %Plotting the filter response


