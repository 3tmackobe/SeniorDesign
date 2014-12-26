clear all; close all; clc;

%% variable variables
d = 1:.1:12; %[inches] amount of error

%% set the fixed variables
l = 60*12 + 6; %[inches]
t = 2.069 - 2.035; %[seconds]

%% calculate max angles

first = [14.650	13.230];
first  = (1/norm(first)).*first;

second = [-15.831	20.260];
second = (1/norm(second)).*second;

omega = acosd(dot(first,second));

omega_dot = omega / t; %degrees / second

%% insert calculations from that plane ride
theta_error = atand(d/(2*l)); % 2l?
f = 1 ./ (theta_error ./ omega_dot);
f = f/1000; %[Khz]

%% plot the calculated variables
hold on
plot(f(71),d(71),'*','MarkerSize',12,'LineWidth',2) %SR = 8 Khz
% plot(f(34),d(34),'*','MarkerSize',12,'LineWidth',2) %SR = 15 Khz
% plot(f(23),d(23),'*','MarkerSize',12,'LineWidth',2) %SR = 20 Khz
plot (f,d,'k');
ylabel('distance error at home plate [Inches]')
xlabel('sample rate [KHz]')
title('Accelerometer Specifications')
grid('on')
ax = gca;
ax.YTick = 1:24;
ax.XTick = 0:5:70;
set(ax,'fontsize',14)
legend('(8 Khz, 8 inches)','location','best')
hold off

%% find the strikezone accuracy in a different chart
l_szone = 21.45; %inches
strikezonesize = l_szone^2;%inches^2
strikezonesize_witherror = (l_szone + 2*d).^2;
% error = strikezonesize_witherror - strikezonesize;
% s = ((error) ./ strikezonesize);
s = 100*((strikezonesize ./ strikezonesize_witherror));

% don't plot this for now
% figure
% plot(d,s,'linewidth',2);
% ylabel('Error in Strike Calculation [%]')
% xlabel('sample rate [KHz]')
% xlabel('distance off at home plate')
% title('Strikezone Calculation Accuracy')
% grid('on')
% ay = gca;
% % ay.YTick = 90:100;
% % ay.XTick = 0:5:70;
% set(ay,'fontsize',14)