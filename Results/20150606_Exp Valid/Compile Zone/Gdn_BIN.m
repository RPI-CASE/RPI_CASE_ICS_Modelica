function [ Gdn_out ] = Gdn_BIN( Gdn_in)

%Gdn_out = zeros(1,length(Gdn_in));

for i = 1:length(Gdn_in)
    if Gdn_in(i) < 365 
        Gdn_in(i) = 3360;
    elseif Gdn_in(i) >= 360 && Gdn_in(i) < 370
        Gdn_in(i) = 360;
    elseif Gdn_in(i) >= 370 && Gdn_in(i) < 380
        Gdn_in(i) = 400;
    elseif Gdn_in(i) >= 425 && Gdn_in(i) < 450
        Gdn_in(i) = 425;
    else
        Gdn_in(i) = 450;
        
    end
end

Gdn_out = Gdn_in;

end

