function [Theta,PI,A,B,B_iter,Jsp]=SMGPFRL1(T,Y,bsbasis)
kmax=9;
kk=1;
% initialization
m=size(T,1);
% N=0;
% for i=1:m
%     N=N+length(T{i});
% end
phi=cell(1,m);
Nm = size(T,2);Curve_num = m;
A = ones(Curve_num,1);
zmat = ones(m,1);
% B = calc_B(T,Y,bsbasis,zmat);
% % % % % % % % % % % % % r
% plot_B(B,T,Y,A,bsbasis)

% % % % % % % % % % % % % % r
for ii = 1:Curve_num
    D{ii}=dist(T(ii,:)).^2;
    for jj = 1:Nm
    phi{ii}(jj,:) = bbase(T(ii,jj),bsbasis,2);
    end
end
[Theta,PI]=Theta_PI_init(kk);
%  B=bspline_update(T,Y,Theta,A,umat,phi);
%  Theta=Theta_update(T,Y,Theta,A,B,phi);
%  A=posterior_update(T,Y,Theta,PI,B,phi);


final=false;
% T,Y,Theta,PI,B,phi,zmat,hardcut_flag
[Theta,PI,A,B]=EM(D,Y,Theta,PI,phi,A,0);
% figure
B_iter{1} = B;
iter=1;
 compare_meanfunction(T,phi,B);
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
         figure;
         plot_curve(T,Y,cluster);
%          title(['components number=',num2str(kk)])
                zmat = zeros(Curve_num,kk);
          for ii=1:Curve_num
             zmat(ii,cluster(ii))=1;
              end
         for ii = 1:Curve_num
           MY(ii,:)=Y(ii,:) - ( phi{ii}*B*zmat(ii,:)')';
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
            [Theta1,PI1,A1,B1]=EM(D,Y,TTheta{ks},TPI{ks},phi,TA,0);
            loglik_old=LogLik(D,Y,Theta,PI,A,B,phi);
            loglik_new=LogLik(D,Y,Theta1,PI1,A1,B1,phi);
          %  [loglik_old loglik_new]
            bic_change=2*(loglik_old-loglik_new)+4*kk*log(Curve_num*Nm);
%             plot_B(B1,T,Y,A1,bsbasis)
 compare_meanfunction(T,phi,B1)
%  plot_B(B,T,Y,A,bsbasis)
%              bic_change
            if bic_change<0
                kk=kk+1;
                split=true;
                Theta=Theta1;
                PI=PI1;
                B=B1;
                A = A1;
                iter = iter+1;
                B_iter{iter} = B;
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
        [Theta,PI,B]=delcomp(Theta,PI,B,0.005);
        kk=length(PI);
% T,Y,Theta,PI,B,phi,zmat,beta)
        A=posterior_update(D,Y,Theta,PI,B,phi);
          [~,cluster]=max(A,[],2);
         figure;
         plot_curve(T,Y,cluster);
%          title(['components number=',num2str(kk)])
    end
end