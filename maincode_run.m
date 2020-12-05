
camera = webcam; % Connect to the camera
preview(camera)
pause(3);
    
     im = snapshot(camera);       % Take a picture
                       
     I = imresize(im,[224 224]); % Resize the picture for alexnet
      figure;subplot(1,2,1);imshow(I); % Show the picture
% 

% im= imread('F:\project\Project-database\testing\e.jpg');
 I= imresize(im,[224 224]);
 
 figure;subplot(1,2,1);imshow(I); % Show the picture

     redChannel = I(:, :, 1);
     greenChannel = I(:, :, 2);
     blueChannel = I(:, :, 3);

I=rgb2hsv(I); 
[r,c,b]=size(I);  %255,255
H = I(:,:,1);
S = I(:, :, 2);
V= histeq(I(:, :, 3));
im=hsv2rgb(cat(3,H,S,V));

 I=rgb2hsv(im);
for i= 1:1:r
    for j= 1:1:c
        h = I(i, j, 1);
        s = I(i, j, 2);
        v = I(i, j, 3);
       if ((0<= h)&&(h <= 0.29) && (0.148 <= s)&&(s <= 0.98))
                
              else
                   I(i,j,:)=0;
              end
       
    end
end

i=hsv2rgb(I);
bin=im2bw(i);

xmm=medfilt2(bin,[3 3]);
xxm=medfilt2(xmm,[5 5]);
SE = strel('square',9);     %A strel object represents a flat morphological structuring element
xd = imdilate(xxm,SE);     %dialation
SE2=strel('square',3);
xe=imerode(xd,SE2);
xdd= imdilate(xe,SE2);
xm=medfilt2(xdd,[7 7]);

a = cast(redChannel,'uint8'); %conversion to uint8 format
b=cast(greenChannel,'uint8');
c=cast(blueChannel,'uint8');
x3 = cast(xm,'uint8');
redfinal = a.*x3;            %multiplying original image components with filtered binary image
greenfinal=b.*x3;
bluefinal=c.*x3;

Im=cat(3,redfinal,greenfinal,bluefinal);

  
Igray=rgb2gray(Im);

     
     cellSize = [16 16];blocksize=[4 4];
     [imghog, vis] = extractHOGFeatures(Igray, 'CellSize', cellSize,'blocksize',blocksize);

      subplot(1,2,2); plot(vis);
   
       y=weights(imghog);
     
      [acc,ind] = max(y);     

      class={'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
      disp('The letter is: ');
      disp(class(ind));   
