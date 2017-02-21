%% IIR filter Code
function y = filterIIR2t(x,Num,Den)
    c = Num; %Numerator coefficients of systen function
    d = Den; %Denominator coefficients of systen function
    
    sz = size(Num);
    k = sz(2) - 1;      % Filter order determines from the length of the 
                        % Number coefficient vector
    reg = zeros(k,1);   % Initial condition
    
    ind = 1;            % Index
    for v = x % Iterate all values from input data vector
        y(ind) = v*c(1) + reg(1);
        reg(1:k-1) = (v*c(2:k) -y(ind)*d(2:k))' + reg(2:k);
        reg(k)= v*c(k+1) - y(ind)*d(k+1);
        ind = ind +1;
    end
        