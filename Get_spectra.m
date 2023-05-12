function [S_a,S_v,S_d] = Get_spectra(Accelerate,dt)
%GET_SPECTRA 此处显示有关此函数的摘要
%   此处显示详细说明
% time = Agt_40s(:,1);
% Accelerate = Agt_40s(:,2);
count = length(Accelerate);
% ***********精确法计算各反应***********
%初始化各储存向量
Displace=zeros(1,count);    %相对位移
Velocity=zeros(1,count);    %相对速度
AbsAcce=zeros(1,count);     %绝对加速度
% ***********A,B矩阵***********
DampA=0.05;
TA=0.0:0.0005:9;      %TA=0.000001:0.02:6;     %结构周期
Dt=dt;               %地震记录的步长
%记录计算得到的反应，MDis为某阻尼时最大相对位移，MVel为某阻尼
%时最大相对速度，MAcc某阻尼时最大绝对加速度，用于画图
MDis=zeros(1,length(TA));
MVel=zeros(1,length(TA));
MAcc=zeros(1,length(TA));

j=1;    %在下一个循环中控制不同的阻尼比
for Damp=[0.05]
  
    t=1;    %在下一个循环中控制不同的结构自振周期
    for T=0.0:0.0005:9
        Frcy=2*pi/T ; %结构自振频率
       
        DamFrcy=Frcy*sqrt(1-Damp*Damp);   %计算公式化简
        e_t=exp(-Damp*Frcy*Dt);
        s=sin(DamFrcy*Dt);
        c=cos(DamFrcy*Dt);
       
        A=zeros(2,2);
           A(1,1)=e_t*(s*Damp/sqrt(1-Damp*Damp)+c);
           A(1,2)=e_t*s/DamFrcy;
           A(2,1)=-Frcy*e_t*s/sqrt(1-Damp*Damp);
           A(2,2)=e_t*(-s*Damp/sqrt(1-Damp*Damp)+c);
          
       d_f=(2*Damp^2-1)/(Frcy^2*Dt); %计算公式化简
       d_3t=Damp/(Frcy^3*Dt);
                
       B=zeros(2,2);
            B(1,1)=e_t*((d_f+Damp/Frcy)*s/DamFrcy+(2*d_3t+1/Frcy^2)*c)-2*d_3t;
            B(1,2)=-e_t*(d_f*s/DamFrcy+2*d_3t*c)-1/Frcy^2+2*d_3t;
            B(2,1)=e_t*((d_f+Damp/Frcy)*(c-Damp/sqrt(1-Damp^2)*s)-(2*d_3t+1/Frcy^2)*(DamFrcy*s+Damp*Frcy*c))+1/(Frcy^2*Dt);
            B(2,2)=e_t*(1/(Frcy^2*Dt)*c+s*Damp/(Frcy*DamFrcy*Dt))-1/(Frcy^2*Dt);
           
       for i=1:(count-1)    %根据地震记录,计算不同的反应
          Displace(i+1)=A(1,1)*Displace(i)+A(1,2)*Velocity(i)+B(1,1)*Accelerate(i)+B(1,2)*Accelerate(i+1);
          Velocity(i+1)=A(2,1)*Displace(i)+A(2,2)*Velocity(i)+B(2,1)*Accelerate(i)+B(2,2)*Accelerate(i+1);
          AbsAcce(i+1)=-2*Damp*Frcy*Velocity(i+1)-Frcy^2*Displace(i+1);
       end
          
       MDis(j,t)=max(abs(Displace));
       MVel(j,t)=max(abs(Velocity));
       if T==0.0
            MAcc(j,t)=max(abs(Accelerate));
       else
           MAcc(j,t)=max(abs(AbsAcce));
       end
      
       Displace=zeros(1,count);%初始化各储存向量，避免下次不同周期计算时引用到前一个周期的结果
       Velocity=zeros(1,count);
       AbsAcce=zeros(1,count);
      
       t=t+1;
    end
   j=j+1;
end

S_a = [TA;MAcc]';
S_v = [TA;MVel]';
S_d = [TA;MDis]';

end

