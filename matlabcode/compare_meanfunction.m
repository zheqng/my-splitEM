function  compare_meanfunction(T,phi,B)
x=T(1,:);
kk=size(B,2);
for k=1:kk
    Y2(k,:) = (phi{1}*B(:,k));
end
[x,I]= sort(x);
M(1,:)=.5*sin(.125*(x-4).^2)+3;
M(2,:)=-3*exp(-(x-4).^2/8)/(2*pi)^.5+3.7;
M(3,:)=-atan(x/2-2)/2+3;
M(4,:) = 0.5*cos(-(x-4).^2/8)+3;
M(5,:) = -1/2*acos(x/4) +3;
M(6,:)=-4*asin(x/4) +3;
M(7,:) = 6*sin(-(x-4).^2/8)+3;
M(8,:)= -32/sqrt(2*pi)*exp(-(x-4).^2/8)+10;
M(9,:) = -1/sqrt(2*pi)*exp((x-4).^2/16)+11;
M(10,:) = 6*cos(-(x-4).^2/8+pi/2)+3;
figure
plot(x,Y2(:,I),'r--');
hold on
for ii=1:10
    plot(x,M(ii,:),'b'); hold on;
end
hold off
pause(1)
