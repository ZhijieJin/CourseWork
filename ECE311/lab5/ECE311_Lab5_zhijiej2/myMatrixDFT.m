function myMatrixDFT = myMatrixDFT(x)
    N = length(x);
    myMatrixDFT = zeros(1, N);
    for k = 1:N
        temp = 0;
        for n = 1:N
            temp = temp + x(n)*exp(-1i*2.0*pi*(k-1)*(n-1)/N);
        end
        myMatrixDFT(k) = temp;
    end
end