function [Theta,PI,A,MU,MU_iter,Jsp]=SMGPFRL1(T,Y)
kmax=9;
kk=1;
% initialization
m=size(T,1);
Nm = size(T,2);Curve_num = m;
A = ones(Curve_num,1);
zmat = ones(m,1);

% % % % % % % % % % % % % % r
for ii = 1:Curve_num
    D{ii}=dist(T(ii,:)).^2;
end
[Theta,PI]=Theta_PI_init(kk);
%  B=bspline_update(T,Y,Theta,A,umat,phi);
%  Theta=Theta_update(T,Y,Theta,A,B,phi);
%  A=posterior_update(T,Y,Theta,PI,B,phi);


final=false;
% T,Y,Theta,PI,B,phi,zmat,hardcut_flag
[Theta,PI,A,MU]=EM(D,Y,Theta,PI,A,0);
% figure
MU_iter{1} = MU;
iter=1;
 %compare_meanfunction(bsbasis,B)
%  plot_B(B,T,Y,A,bsbasis)
% plot_B(B,T,Y,A,bsbasis)
d=repmat(0.5,1,kmax);
d(1)=0;
d(end)=1;
b=flip(d);
split_threshold=1;
while final==false
    % split
    if kk+1<=kmax
        [~,cluster]=max(A,[],2);
%          subplot(1,3,kk)
%          plot_curve(T,Y,cluster);
%                 zmat = zeros(Curve_num,kk);
%           for ii=1:Curve_num
%              zmat(ii,cluster(ii))=1;
%               end
         for ii = 1:Curve_num
           MY(ii,:)=Y(ii,:) - MU(cluster(ii),:); 
%             MLE(k)=-.5*mle(Theta(k,:),T{i},MY);
           end
        [Jsp,TTheta,TPI]=split_criterion2(D,MY,Theta,PI,d,b);
        
          %Jsp
        %  kk
%         if max(Jsp)>split_threshold
 
            [~,ks]=max(Jsp);
            TA=posterior_update(D,MY,TTheta{ks},TPI{ks});
            %TB=B;
%             TB(:,kk+1)=TB(:,kk);
           % TB(:,kk+1) = TB(:,ks);
           % TB(:,kk+2) = TB(:,ks);
           % TB(:,ks) = [];
           % loglik_old1=LogLik(T,Y,Theta,PI,A,B,phi);
           % loglik_new1=LogLik(T,MY,TTheta{ks},TPI{ks},TA,TB,phi);
           % [loglik_old1 loglik_new1]
          

% % % % % % % % % % % % % 
            [Theta1,PI1,A1,MU1]=EM(D,Y,TTheta{ks},TPI{ks},TA,0);
            loglik_old=LogLik(D,Y,Theta,PI,A,MU);
            loglik_new=LogLik(D,Y,Theta1,PI1,A1,MU1);
          %  [loglik_old loglik_new]
            bic_change=2*(loglik_old-loglik_new)+4*kk*log(Curve_num*Nm);
%             plot_B(B1,T,Y,A1,bsbasis)
 %compare_meanfunction(bsbasis,B1)
%  plot_B(B,T,Y,A,bsbasis)
%              bic_change
            if bic_change<0
                kk=kk+1;
                split=true;
                Theta=Theta1;
                PI=PI1;
                MU=MU1;
                A = A1;
                iter = iter+1;
                MU_iter{iter} = MU;
            else
                split=false;
            end
%         else
%             split=false;
%         end
    else
        split=false;
    end
    if ~split
        final=true;
    else
        [Theta,PI,MU]=delcomp(Theta,PI,MU,0.005);
        kk=length(PI);
% T,Y,Theta,PI,B,phi,zmat,beta)
        A=posterior_update(D,Y,Theta,PI,MU);
          [~,cluster]=max(A,[],2);
%          subplot(1,3,kk)
figure;
         plot_curve(T,Y,cluster);
    end
end
