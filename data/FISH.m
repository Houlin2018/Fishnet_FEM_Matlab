%%
clc,clear;
close all hidden;

nfiles = 11;

logx_all = cell(1, nfiles);
Y_all = cell(1, nfiles);

for i = 1:nfiles
    % Construct filename
    if i<=9
        filename = sprintf('sqnom_strength_10_10_WG_uni0p%d.csv', i);
    elseif i==10
        filename = sprintf('sqnom_strength_10_10_WG_uni0p01.csv');
    elseif i==11
        filename = sprintf('sqnom_strength_10_10_WG_uni0p05.csv');
    end

    % Compute transformed CDFs for the current file
    [logx, Y] = computeTransformedCDF(filename);

    % Store transformed CDFs
    logx_all{i} = logx;
    Y_all{i} = Y;
end

% Plot the transformed CDFs
figure();
for i = 1:nfiles
    plot(logx_all{i}, Y_all{i}, 'o');
    pause(0.5);
    hold on;
end


function [logx, Y] = computeTransformedCDF(filename)
    % Read data from CSV file
    dat = readmatrix(filename);

    % Compute histogram and CDF
    [b, x] = hist(dat, 100);
    pdf = cumsum(b / numel(dat));

    % Transform the CDF
    Y = log(-log(1 - pdf));
    logx = log(x);
end



