%
% Woolford Price
% Assignment 2, Problem 1
% Oct 12 2020
%

close all
clear
clc


C1 = [3 4;3 5; 4 4; 4 5];
C2 = [3 2;3 3;4 2;4 3;2 3;2 2;2 1;3 1;4 1;1 1;1 2];
C3 = [4 1;5 2;5 4;5 6]
C4 = [5 4;5 6;6 1;6 3]


X = input("Measurement 1 = ")
Y = input("Measurement 2 = ")




%Code for LDA
mu1=mean(C1);
mu2=mean(C2);
mu3=mean(C3);
mu4=mean(C4);

%Determining the size of data per class
N1=size(C1);
N2=size(C2);
N3=size(C3);
N4=size(C4);
N = N1(1,1)+N2(1,1)+N3(1,1)+N4(1,1);

%Calculating the percent fo points in each class
P1=N1(1,1)/N;
P2=N2(1,1)/N;
P3=N3(1,1)/N;
P4=N4(1,1)/N;

%Calculating (C_i-mean_i)
D1 = C1-ones(N1)*diag(mu1);
D2 = C2-ones(N2)*diag(mu2);
D3 = C3-ones(N3)*diag(mu3);
D4 = C4-ones(N4)*diag(mu4);

%Caluclating the Covariances
S1=(D1'*D1)/N1(1,1);
S2=(D2'*D2)/N2(1,1);
S3=(D3'*D3)/N3(1,1);
S4=(D4'*D4)/N4(1,1);

%The actual LDA

%Calculate the common covariance
Sw =(N1(1,1)*S1+N2(1,1)*S2+N3(1,1)*S3+N4(1,1)*S4)/(N-4);

%Creating Boundaries

%Class 1 and 2 Boundary
A12=(mu2-mu1)*inv(Sw);
B12= log(P2/P1)+.5*(mu1+mu2)*inv(Sw)*(mu1'-mu2');

%Class 1 and 3 boundary 
A31 = (mu3-mu1)*inv(Sw);
B31= log(P3/P1)+.5*(mu1+mu3)*inv(Sw)*(mu1'-mu3');

%Class 1 and 4 Boundary
A41 = (mu4-mu1)*inv(Sw);
B41= log(P4/P1)+.5*(mu1+mu4)*inv(Sw)*(mu1'-mu4');


%Class 2 and 3 Boundary
A32 = (mu3-mu2)*inv(Sw);
B32= log(P3/P2)+.5*(mu2+mu3)*inv(Sw)*(mu2'-mu3');

%Class 2 and 4 Boundary
A24 = (mu4-mu2)*inv(Sw);
B24= log(P4/P2)+.5*(mu2+mu4)*inv(Sw)*(mu2'-mu4');


%Class 3 and 4 Boundary
A34 = (mu3-mu4)*inv(Sw);
B34= log(P3/P4)+.5*(mu4+mu3)*inv(Sw)*(mu4'-mu3');





%Class 1 and 
%plotting 
f1 =@(X,Y) B12 +A12*[X;Y];
f2 =@(X,Y) B31 +A31*[X;Y];
f3 =@(X,Y) B41 +A41*[X;Y];
f4 =@(X,Y) B32 +A32*[X;Y];
f5 =@(X,Y) B24 +A24*[X;Y];
f6 =@(X,Y) B34 +A34*[X;Y];


figure
h3= ezplot(f1,[0 9 0 9]);
set(h3,'LineWidth',2,'Color','r');

hold on
h3=ezplot(f2,[0 9 0 9]);
set(h3,'Linewidth',2,'Color','k');

h3=ezplot(f3,[0 9 0 9]);
set(h3,'Linewidth',2);

h3=ezplot(f4,[0 9 0 9]);
set(h3,'Linewidth',2,'Color','g');

h3=ezplot(f5,[0 9 0 9]);
set(h3,'Linewidth',2,'Color','m');


h3=ezplot(f6,[0 9 0 9]);
set(h3,'Linewidth',2,'Color','b');


%Plot a point

%Deltas
Delta1=log(P1)-.5*mu1*inv(Sw)*mu1'+mu1*inv(Sw)*[X;Y];
Delta2=log(P2)-.5*mu2*inv(Sw)*mu2'+mu2*inv(Sw)*[X;Y];
Delta3=log(P3)-.5*mu3*inv(Sw)*mu3'+mu3*inv(Sw)*[X;Y];
Delta4=log(P4)-.5*mu4*inv(Sw)*mu4'+mu4*inv(Sw)*[X;Y];
plot(X,Y,'.','markersize',30);

%LDA Classification Functions and CLassificiation
if Delta1 > Delta2 && Delta1 > Delta3 && Delta1 > Delta4
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 1'])
    title(['Data Point X = ',num2str(X), ' and Y = ', num2str(Y), ' is in Class 1'])
elseif Delta2 > Delta1 && Delta2 > Delta3 && Delta2 > Delta4
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 2'])
    title(['Data Point X = ',num2str(X), ' and Y = ', num2str(Y), ' is in Class 2'])
elseif Delta3 > Delta1 && Delta3 > Delta2 && Delta3 > Delta4
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 3'])
    title(['Data Point X = ',num2str(X), ' and Y = ', num2str(Y), ' is in Class 3'])
elseif Delta4 > Delta1 && Delta4 > Delta3 && Delta4 > Delta1
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 4'])
    title(['Data Point X = ',num2str(X), ' and Y = ', num2str(Y), ' is in Class 4'])
else 
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' Lies on a boundary'])
    title(['Data point X = ', num2str(X), ' and Y = ', num2str(Y), ' Lies on a boundary'])
end





hold on 
plot(C1(:,1),C1(:,2),'ro','markersize',7)
plot(C2(:,1),C2(:,2),'bs','markersize',7)
plot(C3(:,1),C3(:,2),'kd','markersize',7)
plot(C4(:,1),C4(:,2),'mx','markersize',7)
grid
%
axis([0 9 0 9])
grid on
legend 'Boundary between Class 1 and 2' 'Boundary between Class 1 and 3' 'Boundary between Class 1 and 4' 'Boundary between Class 2 and 3' 'Boundary between Class 2 and 4' 'Boundary between Class 3 and 4' 'Input Data Point' 'Class 1' 'Class 2' 'Class 3' 'Class 4'
