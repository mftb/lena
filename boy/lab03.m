#!/usr/bin/octave -qf
pkg load image 
# Matheus Ferreira Tavares Boy
# RA 103501

arg_list = argv();
img_in = arg_list{1};
img = imread(img_in);

# half-toning
matrix_3 = [6, 8, 4; 1, 0, 3; 5, 2, 7];
# normalization 0-9
normalized_half = floor((im2double(img)) * 9);
normalized_half = kron(normalized_half, ones([3, 3]));
mask_half = repmat(matrix_3, size(img));
# applies limiarization
result_half = (normalized_half > mask_half) * 255;
imwrite(result_half, "lab03_half.pbm");

# bayer
matrix_4 = [0, 12, 3, 15; 8, 4, 11, 7; 2, 14, 1, 13; 10, 6, 9, 5];
# normalization 0-16
normalized_bayer = floor((im2double(img)) * 16);
normalized_bayer = kron(normalized_bayer, ones([4, 4]));
mask_bayer = repmat(matrix_4, size(img));
# applies limiarization
result_bayer = (normalized_bayer > mask_bayer) * 255;
imwrite(result_bayer, "lab03_bayer.pbm");

# (pink) floyd
new_img = double(padarray(img, [1, 1], 'symmetric'));
[nr, nc] = size(new_img);
result_pink_floyd = ones([nr, nc]);
mask_pink_floyd = [0, 0, 0; 0, 0, 7/16; 3/16, 5/16, 1/16];
for i = 2 : (nr - 1)
	for j = 2 : (nc - 1)
	    x = i;
	    # alternate sweep
	    if (mod(x, 2))
	        y = j;
	    else
	        y = nc - (j - 1);
	    endif
	    result_pink_floyd(x, y) = (new_img(x, y) > 128) * 255;
	    err = double(new_img(x, y) - result_pink_floyd(x, y));
	    new_img(x-1:x+1, y-1:y+1) = new_img(x-1:x+1, y-1:y+1) + mask_pink_floyd * err;
	endfor
endfor
# crops the matrix out of the padding
result_pink_floyd = result_pink_floyd(2:nr-1, 2:nc-1);
imwrite(result_pink_floyd, "lab03_floyd.pbm");

