function [feature] = get_IM(sudu,weiyi,jiasudu)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
feature = zeros(70);
PGV = max(abs(sudu));
%反应谱
[S_a,S_v,S_d] = Get_spectra(Agt,dt);

%%No.49
I_A = pi/2/g*trapz(dt_simulink,ug_pp(:,2).^2);
feature(49)= I_A;

%%No.41plot
I_A_cum = pi/2/g*cumtrapz(dt_simulink,ug_pp(:,2).^2);
order_t_1 = find(I_A_cum>0.05*I_A,1);
order_t_2 = find(I_A_cum>0.95*I_A,1);
t_1 = order_t_1*dt_simulink;
t_2 = order_t_2*dt_simulink;
T_d = t_2 - t_1;
feature(41)= T_d;
T_f = t_end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%No.1
PGA = max(abs(ug_pp(:,2)));
feature(1)= PGA;

%%No.2
PGV = max(abs(ug_p(:,2)));
feature(2)= PGV;

%%No.3
PGD = max(abs(ug(:,2)));
feature(3)= PGD;

%%No.4
A_pks = sort(findpeaks(abs(ug_pp(:,2))),'descend');
SMA = A_pks(3);
feature(4)= SMA;

%%No.5
V_pks = sort(findpeaks(abs(ug_p(:,2))),'descend');
SMV = V_pks(3);
feature(5)= SMV;

%%No.6
PSA = max(S_a(:,2));
feature(6)= PSA;

%%No.7
[PSV,order_PSV] = max(S_v(:,2));
feature(7)= PSV;

%%No.8
PSD = max(S_d(:,2));
feature(8)= PSD;

%%No.9
order_t1 = find(S_a(:,1)==T_1);
sat1 = S_a(order_t1,2);
feature(9)= sat1;

%%No.10
svt1 = S_v(order_t1,2);
feature(10)= svt1;

%%No.11
sdt1 = S_d(order_t1,2);
feature(11)= sdt1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%No.12
CAV = trapz(dt_simulink,abs(ug_pp(:,2)));
feature(12)= CAV;

%%No.13
CAD = trapz(dt_simulink,abs(ug_p(:,2)));
feature(13)= CAD;

%%No.14
CAI = trapz(dt_simulink,abs(ug(:,2)));
feature(14)= CAI;

%%No.15
A_sq = trapz(dt_simulink,ug_pp(:,2).^2);
feature(15)= A_sq;

%%No.16
V_sq = trapz(dt_simulink,ug_p(:,2).^2);
feature(16)= V_sq;

%%No.17
D_sq = trapz(dt_simulink,ug(:,2).^2);
feature(17)= D_sq;  
    
%%No.18
A_rs = sqrt(A_sq);
feature(18)= A_rs;

%%No.19
V_rs = sqrt(V_sq);
feature(19)= V_rs;

%%No.20
D_rs = sqrt(D_sq);
feature(20)= D_rs;

%%No.21
P_a = 1/T_d*trapz(dt_simulink,ug_pp(order_t_1:order_t_2,2).^2);
feature(21)= P_a;

%%No.22
P_v = 1/T_d*trapz(dt_simulink,ug_p(order_t_1:order_t_2,2).^2);
feature(22)= P_v;

%%No.23
P_d = 1/T_d*trapz(dt_simulink,ug(order_t_1:order_t_2,2).^2);
feature(23)= P_d;

%%No.24
A_rms = sqrt(P_a);
feature(24)= A_rms;

%%No.25
V_rms = sqrt(P_v);
feature(25)= V_rms;

%%No.26
D_rms = sqrt(P_d);
feature(26)= D_rms;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%No.27
order_t_zerodot1 = find(S_a(:,1)==0.1);
order_t_zerodot5 = find(S_a(:,1)==0.5);
ASI = trapz(dt_spetrum,S_a(order_t_zerodot1:order_t_zerodot5,2));
feature(27)= ASI;

%%No.28
order_t_2dot5 = find(S_v(:,1)==2.5);
VSI1 = trapz(dt_spetrum,S_v(order_t_zerodot1:order_t_2dot5,2));
feature(28)= VSI1;

%%No.29
order_t_0dot7 = find(S_d(:,1)==0.7005)-1;  %此处为什么减一？
order_t_2dot0 = find(S_d(:,1)==2);
VSI2 = trapz(dt_spetrum,S_v(order_t_0dot7:order_t_2dot0,2));
feature(29)= VSI2;
    
%%No.30
order_t_4dot0 = find(S_d(:,1)==4.0);
DSI1 = trapz(dt_spetrum,S_d(order_t_2dot5:order_t_4dot0,2));
feature(30)= DSI1;

%%No.31
order_t_2dot0 = find(S_d(:,1)==2);
order_t_5dot0 = find(S_d(:,1)==5);
DSI2 = trapz(dt_spetrum,S_d(order_t_2dot0:order_t_5dot0,2));
feature(31)= DSI2;

%%No.32
order_t_0dot5T = find(S_a(:,1)==(0.5*T_1));
order_t_1dot25T = find(S_a(:,1)==roundn(1.25*T_1+dt_simulink,-4))-1;
MASI = trapz(dt_spetrum,S_a(order_t_0dot5T:order_t_1dot25T,2));
feature(32)= MASI;

%%No.33
MVSI = trapz(dt_spetrum,S_v(order_t_0dot5T:order_t_1dot25T,2));
feature(33)= MVSI;

%%No.34
MDSI = trapz(dt_spetrum,S_d(order_t_0dot5T:order_t_1dot25T,2));
feature(34)= MDSI;

%%No.35
%     order_t_0dot8T = find(S_a(:,1)==(t_0dot8T));
order_t_0dot8T = find(roundn(S_a(:,1),-4)==(t_0dot8T));
order_t_1dot2T = find(S_d(:,1)==(t_1dot2T));
VSI_kappos = trapz(dt_spetrum,S_a(order_t_0dot8T:order_t_1dot2T,2));
feature(35)= VSI_kappos;

%%No.36
EPA1 = ASI/2.5;
feature(36)= EPA1;

%%No.37
EPA2 = trapz(dt_spetrum,S_a(order_t_zerodot1:order_t_2dot5,2))/2.5;
feature(37)= EPA2;
    
%%No.38
order_t_zerodot8 = find(S_v(:,1)==0.8);
order_t_1dot2 = find(S_v(:,1)==1.2);
EPV1 = trapz(dt_spetrum,S_v(order_t_zerodot8:order_t_1dot2,2))/2.5;
feature(38)= EPV1;

%%No.39
EPV2 = trapz(dt_spetrum,S_v(order_t_0dot7:order_t_2dot0,2))/2.5;
feature(39)= EPV2;

%%No.40
EPD = DSI2/2.5;
feature(40)= EPD;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%No.42
EPV3 = trapz(dt_spetrum,S_v(order_t_zerodot5:order_t_2dot0,2))/1.5;
EPA3 = trapz(dt_spetrum,S_a(order_t_zerodot1:order_t_zerodot5,2))/0.4;
T_g = 2*pi*EPV3/EPA3;
feature(42)= T_g;

%%No.43
FR_1 = PGA/PGV;
feature(43)= FR_1;

%%No.44
FR_2 = PGV/PGD;
feature(44)= FR_2;

%%No.45
FR_3 = PGV/PGA;
feature(45)= FR_3;

%%No.46
FR_4 = PGD/PGV;
feature(46)= FR_4;

%%No.47
FR_5 = PGD/PGA;
feature(47)= FR_5;

%%No.48
FR_6 = PGA/PGD;
feature(48)= FR_6;
        
%%No.50
I_V = V_sq/PGV;
feature(50)= I_V;

%%No.51
I_D = D_sq/PGD;
feature(51)= I_D;

%%No.52
I_Z = A_sq/PGA/PGV;
feature(52)= I_Z;

%%No.53
I_a = PGA*(T_d^(1/3));
feature(53)= I_a;

%%No.54
I_c = (A_rms^1.5)*(T_d^0.5);
feature(54)= I_c;

%%No.55
I_v = (PGV^(2/3))*(T_d^(1/3));
feature(55)= I_v;

%%No.56
I_d = PGD*(T_d^(1/3));
feature(56)= I_d;

%%No.57
I_F = PGV*(T_d^0.25);
feature(57)= I_F;

%%No.58
I_ch = PGV*(T_d^0.15);
feature(58)= I_ch;

%%No.59
I_VA = sqrt(PGV*A_sq);
feature(59)= I_VA;

%%No.60
A95 = 0.764*(I_a^0.438);
feature(60)= A95;

%%No.61
order_0dot5PGA = find(abs(ug_pp(:,2))>PGA/2,1);  % find到的是ug_pp第二列超过0.5GPA的索引，是否是一个向量呢？find(,1)是 返回第一个超过的索引吗？
I_ap = PGA*(((order_0dot5PGA-1)*dt_simulink)^0.5);
feature(61)= I_ap;

%%No.62
v_0 = length(find((ug_pp(1:length_motions,2).*ug_pp(2:(length_motions+1),2))<0))/t_end;
I_AM = I_A/v_0/v_0;
feature(62)= I_AM;
       
%%No.63
AverageAccelerationSpectrum = mean(S_a(1:10001,2));
feature(63)= AverageAccelerationSpectrum;

%%No.64
AverageVelocitySpectrum = mean(S_v(1:10001,2));
feature(64)= AverageVelocitySpectrum;

%%No.65
AverageDriftSpectrum = mean(S_d(1:10001,2));
feature(65)= AverageDriftSpectrum;

%%No.66
order_2t1 = find(S_a(:,1)==roundn((2*T_1+dt_simulink),-4))-1;
sa2t1 = S_a(order_2t1,2);
IM_12 = sat1^(0.5)*sa2t1^(0.5);
feature(66)= IM_12;

%%No.67
%     order_15t1 = find(S_a(:,1)==roundn((1.5*T_1+dt_simulink),-4))-1;
order_15t1 = find(S_a(:,1)==roundn((1.5*T_1),-4))-1;
sa15t1 = S_a(order_15t1,2);
S_N1 = sat1^(0.5)*sa15t1^(0.5);
feature(67)= S_N1;
        
%%No.68
order_t2 = find(S_a(:,1)==T_2);
sat2 = S_a(order_t2,2);
order_t3 = find(S_a(:,1)==T_3);
sat3 = S_a(order_t3,2);
IM_123 = sat1^(1/3)*sat2^(1/3)*sat3^(1/3);
feature(68)= IM_123;
       
%%No.69
S_N2 = sat1^(0.75)*sat2^(0.25);
feature(69)= S_N2;

%%No.70
S_a123 = 0.8*sat1+0.15*sat2+0.05*sat3;
feature(70)= S_a123;
end

