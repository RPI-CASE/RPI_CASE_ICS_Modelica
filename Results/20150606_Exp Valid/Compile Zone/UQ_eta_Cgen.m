function [ eta_cgen_out, s_eta_cgen_out ] = UQ_eta_Cgen( Qgen_in, s_Qgen_in, Egen_in, Gdn_in)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

syms eta_cgen Qgen Egen Gdn;
syms s_eta_cgen s_Qgen s_Egen s_Gdn;

eta_cgen(Qgen,Egen,Gdn) = (Qgen + Egen) / Gdn; 

s_eta_cgen(Qgen,Egen,Gdn,s_Qgen,s_Egen,s_Gdn) = sqrt(...
    diff(eta_cgen,Qgen)^2*s_Qgen^2 + diff(eta_cgen,Egen)^2*s_Egen^2 + ...
    diff(eta_cgen,Gdn)^2*s_Gdn^2);

%INIT Uncertainlty values
s_Egen_in = 0.73; % check BITCOPT1 appendix for value
%s_Gdn_in = Gdn_in*(5/100);
%s_Gdn_in = 7.6; %no uncertainity in area
s_Gdn_in = 10; %With area un. of 1% assumes max error at each point

s_eta_cgen_out = double(s_eta_cgen(Qgen_in,Egen_in,Gdn_in,s_Qgen_in,s_Egen_in,...
    s_Gdn_in));
eta_cgen_out = double(eta_cgen(Qgen_in,Egen_in,Gdn_in));

end

