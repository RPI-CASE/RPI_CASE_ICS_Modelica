function [ s_eta_Qgen_out ] = UQ_eta_Qgen( Qgen_in, s_Qgen_in, Gdn_in)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

syms eta_Qgen Qgen Gdn;
syms s_eta_Qgen s_Qgen s_Gdn;

eta_Qgen(Qgen,Gdn) = (Qgen) / Gdn; 

s_eta_Qgen(Qgen,Gdn,s_Qgen,s_Gdn) = sqrt(diff(eta_Qgen,Qgen)^2*s_Qgen^2 + ...
    diff(eta_Qgen,Gdn)^2*s_Gdn^2);

%INIT Uncertainlty values
%s_Gdn_in = Gdn_in*(5/100);
%s_Gdn_in = 7.6; %no uncertainity in area
s_Gdn_in = 10; %With area un. of 1% assumes max error at each point

s_eta_Qgen_out = double(s_eta_Qgen(Qgen_in,Gdn_in,s_Qgen_in,s_Gdn_in));
end

