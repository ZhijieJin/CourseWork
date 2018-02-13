function [dft2] = myDFT2(image)
    [row, col] = size(image);
    
    dft2 = zeros(row, col);
    for m = 1:row
        dft2(m,:) = fft(image(m,:));
    end
    
    for n = 1:col
        dft2(:,n) = fft(dft2(:, n));
    end
end