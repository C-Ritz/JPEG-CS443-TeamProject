% Quantize a YCbCr image.
function quantized = quantize(inputImg, qf)
    % Define the quantization tables.
    QY = [16 11 10 16 24 40 51 61 ;
          12 12 14 19 26 58 60 55 ;
          14 13 16 24 40 57 69 56 ;
          14 17 22 29 51 87 80 62 ;
          18 22 37 56 68 109 103 77 ;
          24 35 55 64 81 104 113 92 ;
          49 64 78 87 103 121 120 101 ;
          72 92 95 98 112 100 103 99];
    QC = [17 18 24 47 99 99 99 99 ;
          18 21 26 66 99 99 99 99 ;
          24 26 56 99 99 99 99 99 ;
          47 66 99 99 99 99 99 99 ;
          99 99 99 99 99 99 99 99 ;
          99 99 99 99 99 99 99 99 ;
          99 99 99 99 99 99 99 99 ;
          99 99 99 99 99 99 99 99];
    % Modify the quantization tables according to the qf.
    if qf >= 50
        sf = (100 - qf) / 50;
    else
        sf = 50 / qf;
    end
    if sf ~= 0
        QxY = ceil(QY * sf);
        QxC = ceil(QC * sf);
    else
        QxY = ones(8, 8);
        QxC = ones(8, 8);
    end
    QxY = uint8(QxY);
    QxC = uint8(QxC);

    % Get size of input image
    [rows, cols] = size(inputImg(:, :, 1));
    % Generate zero matrix with same dimensions as input image
    quantized = zeros(rows, cols, 3); 
    % Loop through inputImg matrix
    for i = 0:1 : rows-1             
        for j = 0:1 : cols-1
            % Calculate the quantized pixel value by dividing the current
            % pixel value by the element in the quantization matrix.
            quantized(i + 1, j + 1, 1) = round(inputImg(i + 1, j + 1, 1) / QxY(mod(i, 8) + 1, mod(j, 8) + 1));
            quantized(i + 1, j + 1, 2) = round(inputImg(i + 1, j + 1, 2) / QxC(mod(i, 8) + 1, mod(j, 8) + 1));
            quantized(i + 1, j + 1, 3) = round(inputImg(i + 1, j + 1, 3) / QxC(mod(i, 8) + 1, mod(j, 8) + 1));
        end
    end
end
