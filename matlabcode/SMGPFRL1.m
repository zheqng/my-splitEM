function [BIC,Theta,PI,A,component_num]=SMGPFRL1(T,Y)
kmax=30;
kk=1;
% initialization
m=size(T,1);
Nm = size(T,2);Curve_num = m;
A = ones(Curve_num,1);
% % % % % % % % % % % % % % r
for ii = 1:Curve_num
    D{ii}=dist(T(ii,:)).^2;
end
[Theta,PI]=Theta_PI_init(kk);

%____________________prepare for iterations___________________%
final=false;
[Theta,PI,A]=EM(D,Y,Theta,PI,A,0);
d=repmat(0.5,1,kmax);
d(1)=0;
d(end)=1;
b=flip(d);
split_threshold=1;
loglik_new=LogLik(D,Y,Theta,PI,A);
BIC=-2*loglik_new+4*kk*log(Curve_num*Nm);
component_num=[];
%______________________start iterations_________________________%
while final==false
    
    [ratio,final,Theta_new,PI_new]=split_criterion2(D,Y,Theta,PI,d,b);
    
    close all;
    if random('unif',0,1,1)<ratio
        split=true;
        %___________fix k moves_______________________________%
        A_new=posterior_update(D,Y,Theta_new,PI_new);
        [Theta_new,PI_new,A_new]=EM(D,Y,Theta_new,PI_new,A_new,0);
        [Theta_new,PI_new]=delcomp(Theta_new,PI_new,A_new);
        A_new=posterior_update(D,Y,Theta_new,PI_new);
        %__________calc BIC___________________________________%
        kk=length(PI_new)
        %         loglik_old=LogLik(D,Y,Theta,PI,A);
        loglik_new=LogLik(D,Y,Theta_new,PI_new,A_new);
        %  [loglik_old loglik_new]
        %         BIC_tmp=-2*loglik_new+2*loglik_old+4*kk*log(Curve_num*Nm);
        BIC = [BIC -2*loglik_new+4*kk*log(Curve_num*Nm)]
        if final == false
            component_num = [component_num kk];
            %_____________plot figure_______________________________%
            [~,cluster]=max(A_new,[],2);
            figure;
            plot_curve(T,Y,cluster);
            pause(1)
            %______________update parameters________________________%
            Theta=Theta_new;
            PI=PI_new;
            A = A_new;
        end
    end
end
% end
plot(BIC)
