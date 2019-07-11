function [T,Y,MU,m_class]=generate(Curve_num)
x=linspace(-4,4,101);
m_class=mnrnd(Curve_num,[1/3,1/3,1/3]);
MU(1,:)=.5*sin(.125*(x-4).^2)+3;
MU(2,:)=-3*exp(-(x-4).^2/8)/(2*pi)^.5+3.7;
MU(3,:)=-atan(x/2-2)/2+3;
n=length(x);
T = zeros(Curve_num,n);

    T(1:m_class(1),:)=repmat(x,m_class(1),1);
    D=dist(x').^2;
    C=.4*exp(-.5*D)+.004*eye(n);
    Tau1=mvnrnd(zeros(1,n),C,m_class(1));
    Y(1:m_class(1),:)=MU(1,:)+Tau1;

    T((m_class(1)+1):(m_class(1)+m_class(2)),:)=repmat(x,m_class(2),1);
    D=dist(x').^2;
    C=.2*exp(-.25*D)+.004*eye(n);
    Tau2=mvnrnd(zeros(1,n),C,m_class(2));
    Y((m_class(1)+1):(m_class(1)+m_class(2)),:)=MU(2,:)+Tau2;

    T((m_class(1)+m_class(2)+1):Curve_num,:)= repmat(x,m_class(3),1);
    D=dist(x').^2;
    C=.1*exp(-.1*D)+.004*eye(n);
    Tau3=mvnrnd(zeros(1,n),C,m_class(3));
    Y((m_class(1)+m_class(2)+1):Curve_num,:)=MU(3,:)+Tau3;

