% Perform chroma subsampling 4:2:2 on a YCbCr image.
function subsampled = subsample(inputImg)
    % Get size of input image
    [rows, cols] = size(inputImg(:,:,1));
    % Generate zero matrix with same dimensions as input image
    subsampled = zeros(rows, cols, 3);
    % 4:2:2 subsampling can be done row by row.
    for x = 0:1 : rows-1
        for y = 0:1 : cols-1
            % Each even column will have its cb and cr values applied to the
            % corresponding odd column.
            if mod(y, 2) == 0
                cb = double(inputImg(x + 1, y + 1, 2));
                cr = double(inputImg(x + 1, y + 1, 3));
            end
            % Luminance is copied over, while the chroma elements are
            % are taken from the cb and cr values.
            subsampled(x + 1, y + 1, 1) = double(inputImg(x + 1, y + 1, 1));
            subsampled(x + 1, y + 1, 2) = cb;
            subsampled(x + 1, y + 1, 3) = cr;
        end
    end
end
