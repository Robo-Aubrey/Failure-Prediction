%
%Woolford Price
%Assignment 1, Problem 3
%Oct 12 2020
%

close all
clear
clc

X = input("Measurement 1 = ")
Y = input("Measurement 2 = ")

%Data
C1 = [3 4;3 5; 4 4; 4 5];
C2 = [3 2;3 3;4 2;4 3;2 3;2 2;2 1;3 1;4 1;1 1;1 2];

% hold on
% grid
% xlabel('X')
% ylabel('Y')
% plot(C1(:,1),C1(:,2),'bs')
% plot(C2(:,1),C2(:,2),'rs')

%Statistics
N1=size(C1);
N2=size(C2);
N=N1(1,1)+N2(1,1);
P1=N1(1,1)/N;
P2=N2(1,1)/N;
mu1=mean(C1);
mu2=mean(C2);
S1=cov(C1);
S2=cov(C2);

%Setting up constants for the QDA
hold on;
Aq=.5*(inv(S1)-inv(S2));
bq = -mu1*inv(S1)+mu2*inv(S2);
cq = .5*log(det(S1)/det(S2))+.5*(-mu2*inv(S2)*mu2'+mu1*inv(S1)*mu1')+log(P2/P1);

%
%
%Plotting Results
hold on
grid
xlabel('X')
ylabel('Y')
g = @(X,Y) cq+bq*[X;Y]+ [X,Y]*Aq*[X;Y];
h2 = ezplot(g,[0 5 0 6]);
h2.Color = 'k';
h2.LineWidth = 2;
plot(C1(:,1),C1(:,2),'bs')
plot(C2(:,1),C2(:,2),'rs')
plot(X,Y,'.','markersize',30,'color','m');


legend 'Quadratic Discriminant Analysis Boundary' 'Class One' 'Class Two' 'Entered Data Point'



Delta1 = -.5*([X,Y]-mu1)*inv(S1)*([X;Y]-mu1')-.5*log(det(S1))+log(P1);
Delta2 = -.5*([X,Y]-mu2)*inv(S2)*([X;Y]-mu2')-.5*log(det(S2))+log(P2);

if Delta1 > Delta2 
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 1'])
    title(['Data Point X = ',num2str(X), ' and Y = ', num2str(Y), ' is in Class 1'])
elseif Delta2 > Delta1
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 2'])
    title(['Data point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 2'])
else
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), 'is on a boundary'])
    title(['Data point X = ', num2str(X), ' and Y = ', num2str(Y), ' is on a boundary'])
end

