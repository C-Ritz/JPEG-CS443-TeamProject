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
        sf = (100-qf)/50;
    else
        sf = (50/qf);
    end
    if sf ~= 0
        QY = uint8(round(sf * QY));
        QC = uint8(round(sf * QC));
    else
        QY = uint8(ones(8,8));
        QC = uint8(ones(8,8));
    end

    % Loop through inputImg matrix, first by plane, then by 8x8 block. 
    for k = 1:3
        for i = 1:8:size(inputImg, 1)
            for j = 1:8:size(inputImg, 2)
                % Use the Luminance quantization table if it's the
                % luminance plane, otherwise use the chroma table.
                if k == 1
                    inputImg(i:i+7, j:j+7, k) = round(inputImg(i:i+7, j:j+7, k) ./ double(QY));
                else
                    inputImg(i:i+7, j:j+7, k) = round(inputImg(i:i+7, j:j+7, k) ./ double(QC));
                end
            end
        end
    end
    
    % Do the same to dequantize, but multiply with the quantization table instead of dividing.
    for k = 1:3
        for i = 1:8:size(inputImg,1)
            for j = 1:8:size(inputImg,2)
                if k == 1
                    inputImg(i:i+7, j:j+7, k) = round(inputImg(i:i+7, j:j+7, k) .* double(QY));
                else
                    inputImg(i:i+7, j:j+7, k) = round(inputImg(i:i+7, j:j+7, k) .* double(QC));
                end
            end
        end
    end
    quantized = inputImg;
end
