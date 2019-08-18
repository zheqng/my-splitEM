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
[Theta,PI,A]=EM(D,Y,Theta,PI,A);
d=repmat(0.5,1,kmax);
d(1)=0;
d(end)=1;
b=flip(d);
split_threshold=1;
loglik=LogLik(D,Y,Theta,PI);
BIC=-2*loglik+4*kk*log(Nm);
% BIC=-2*loglik+4*kk;
%  BIC=-2*loglik;

component_num=[];
%______________________start iterations_________________________%
while final==false
    %_______________-split the mean func curves______________________%
    [ratio,final,Theta_new,PI_new]=split_criterion2(D,Y,Theta,PI,loglik,d,b);
    
    % close all;
    if random('unif',0,1,1)<ratio
        % split=true;
        %___________fix k moves_______________________________%
        A_new=posterior_update(D,Y,Theta_new,PI_new);
        [Theta_new,PI_new,A_new]=EM(D,Y,Theta_new,PI_new,A_new);
        [Theta_new,PI_new]=delcomp(Theta_new,PI_new,A_new);
        A_new=posterior_update(D,Y,Theta_new,PI_new);
        %__________calc BIC___________________________________%
        kk=length(PI_new)
        loglik_new=LogLik(D,Y,Theta_new,PI_new);
        BIC = [BIC -2*loglik_new+4*kk*log(Nm)];
        BIC_tmp= [2*loglik_new+2*loglik 4*log(Nm)]
        %                 BIC = [BIC -2*loglik_new+4*kk]
        %  BIC = [BIC -2*loglik_new]
        %___________judge final via BIC_________________________%
        if BIC(end)>BIC(end-1)
            split = false;
            
        else
            split = true;
            component_num = [component_num kk];
            %______________update parameters________________________%
            Theta=Theta_new;
            PI=PI_new;
            loglik = loglik_new;
            A = A_new;
        end
    end
end
