function  compare_meanfunction(T,phi,B)
x=T(1,:);
kk=size(B,2);
for k=1:kk
Y2(k,:) = (phi{1}*B(:,k));
end
[x,I]= sort(x);
% M11=.5*sin(.125*(x-4).^2)+3;
%   M21=-3*exp(-(x-4).^2/8)/(2*pi)^.5+3.7;
%      M51=-atan(x/2-2)/2+3;
     figure
     plot(x,Y2(:,I),'r--');
%      hold on
%      plot(x,M11,'b',x,M21,'b',x,M51,'b'); hold off
%      pause(1)