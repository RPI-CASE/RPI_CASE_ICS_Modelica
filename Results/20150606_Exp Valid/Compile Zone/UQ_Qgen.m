function [ s1_Qgen ] = UQ_Qgen( V_dot_in, T1_in, T2_in)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

syms Q_dot V_dot cp rho T2 T1;
syms s_Q_dot s_V_dot s_cp s_rho s_T2 s_T1;


Q_dot(V_dot,cp,rho,T1,T2) = V_dot * cp * rho * (T2 - T1);

s_Q_dot(V_dot,cp,rho,T1,T2,s_V_dot,s_cp,s_rho,s_T1,s_T2) = sqrt(...
    diff(Q_dot,V_dot)^2 * s_V_dot^2 + diff(Q_dot,cp)^2 * s_cp^2 + ...
    diff(Q_dot,rho)^2 * s_rho^2 + diff(Q_dot,T1)^2 * s_T1^2 + ...
    diff(Q_dot,T2)^2 * s_T2^2);

% % INIT rho and cp
cp_in = 4190;
rho_in = 974.9;
%INIT Uncertainlty values
s_V_dot_in = (3.5e-06)*0.05;
s_T1_in = 0.5;
s_T2_in = 0.5;
s_cp_in =  cp_in*(1/100);
s_rho_in = rho_in*(1/100);

%Convert symbolic to numeric double
s1_Qgen = double(s_Q_dot(V_dot_in,cp_in,rho_in,T1_in,T2_in,s_V_dot_in,s_cp_in,...
    s_rho_in,s_T1_in,s_T2_in));

%OUT PUT WITH NO CONTRIBUTIONS FROM CP & RHO
s2_Qgen = double(s_Q_dot(V_dot_in,cp_in,rho_in,T1_in,T2_in,s_V_dot_in,0,...
    0,s_T1_in,s_T2_in));

end

