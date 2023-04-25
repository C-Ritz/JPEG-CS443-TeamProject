% Quantize a YCbCr image.
function quantized = quantize(inFile, qf)
    % Define the quantization tables.
    N = 8;
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
    % Determine the scaling_factor based on qf
if qf >= 50
    scaling_factor = (100-qf)/50;
else
    scaling_factor = (50/qf);
end
% Calculate new quantization tables
if scaling_factor ~= 0
    QY = uint8(round(scaling_factor * QY));
    QC = uint8(round(scaling_factor * QC));
else
    QY = uint8(ones(8,8));
    QC = uint8(ones(8,8));
end
% Quantize the Luminance and Chrominance of the Image
for k = 1:3
    for i = 1:N:size(inFile,1)
        for j = 1:N:size(inFile,2)
            if k == 1
                inFile(i:i+N-1, j:j+N-1, k) = round(inFile(i:i+N-1, j:j+N-1, k)./double(QY));
            else
                inFile(i:i+N-1, j:j+N-1, k) = round(inFile(i:i+N-1, j:j+N-1, k)./double(QC));
            end
        end
    end
end
for k = 1:3
    for i = 1:N:size(inFile,1)
        for j = 1:N:size(inFile,2)
            if k == 1
                inFile(i:i+N-1, j:j+N-1, k) = round(inFile(i:i+N-1, j:j+N-1, k).*double(QY));
            else
                inFile(i:i+N-1, j:j+N-1, k) = round(inFile(i:i+N-1, j:j+N-1, k).*double(QC));

            end
        end
    end
    quantized = inFile;
end
%     if qf >= 50
%         sf = (100 - qf) / 50;
%     else
%         sf = 50 / qf;
%     end
%     if sf ~= 0
%         QY = round(QY * sf);
%         QC = round(QC * sf);
%     else
%         QY = ones(8, 8);
%         QC = ones(8, 8);
%     end
%     QY = uint8(QY);
%     QC = uint8(QC);
% 
%     % Get size of input image
%     [rows, cols] = size(inputImg(:, :, 1));
%     % Generate zero matrix with same dimensions as input image
%     quantized = zeros(rows, cols, 3); 
%     % Loop through inputImg matrix
%     for i = 0:1 : rows-1             
%         for j = 0:1 : cols-1
%             % Calculate the quantized pixel value by dividing the current
%             % pixel value by the element in the quantization matrix.
%             quantized(i + 1, j + 1, 1) = round(inputImg(i + 1, j + 1, 1) / QY(mod(i, 8) + 1, mod(j, 8) + 1));
%             quantized(i + 1, j + 1, 2) = round(inputImg(i + 1, j + 1, 2) / QC(mod(i, 8) + 1, mod(j, 8) + 1));
%             quantized(i + 1, j + 1, 3) = round(inputImg(i + 1, j + 1, 3) / QC(mod(i, 8) + 1, mod(j, 8) + 1));
%         end
%     end
%     
%     [rows, cols] = size(quantized(:, :, 1));
%     % Generate zero matrix with same dimensions as input image
%     dequantized = zeros(rows, cols, 3); 
%     % Loop through inputImg matrix
%     for i = 0:1 : rows-1             
%         for j = 0:1 : cols-1
%             % Calculate the quantized pixel value by dividing the current
%             % pixel value by the element in the quantization matrix.
%             dequantized(i + 1, j + 1, 1) = quantized(i + 1, j + 1, 1) * QY(mod(i, 8) + 1, mod(j, 8) + 1);
%             dequantized(i + 1, j + 1, 2) = quantized(i + 1, j + 1, 2) * QC(mod(i, 8) + 1, mod(j, 8) + 1);
%             dequantized(i + 1, j + 1, 3) = quantized(i + 1, j + 1, 3) * QC(mod(i, 8) + 1, mod(j, 8) + 1);
%         end
%     end
%     quantized = dequantized;
end
