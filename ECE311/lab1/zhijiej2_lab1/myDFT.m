%% 7.Function
function output = myDFT(x)
    output = [];
    for k = 1:length(x)
        temp = 0;
        for n = 1:length(x)
            temp = temp + x(n)*exp(-1i*2*pi*(k-1)*(n-1)/length(x));
        end
        output = [output temp];
    end
end